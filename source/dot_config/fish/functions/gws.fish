function gws --description "Create a worktree as a jj colocated workspace of the directory repo (branch + wt hooks included)"
    # usage: gws [--path-file FILE] [--attach] <branch> [base-revision]
    #
    # The companion to ginit: wt hooks CANNOT create jj workspaces (jj refuses
    # to adopt a worktree wt already created, and wt refuses to switch to a
    # jj-created detached worktree), so creation goes through this function.
    # REMOVAL needs no companion: ginit seeds a wt [post-remove] hook that runs
    # `jj workspace forget {{ branch }}`, so plain `wt remove` cleans up both.
    #
    # Runs `jj workspace add` from the MAIN workspace so the new workspace
    # inherits main's full sparse patterns (the default workspace at the
    # wrapper is sparse-cleared and must never be the context for an add).
    #
    # --attach plants the workspace on a branch that ALREADY exists (the
    # workspace starts at that branch) instead of creating one, so the base
    # revision has no meaning there. --path-file writes the workspace path to
    # FILE as one line, for callers that cannot follow the cd at the end.

    # options come first so that `--` can rescue a branch name starting with -
    argparse --name gws 'p/path-file=' a/attach -- $argv
    or return 1

    # The flags are parsed before anything cds, so this is still the caller's
    # cwd — a relative FILE is relative to where they stood, not to
    # <wrapper>/main, which is only where the workspace is created from.
    set -l caller_cwd (pwd)
    set -l path_file ''
    if set -q _flag_path_file
        set path_file $_flag_path_file
        if test -z "$path_file"
            echo "gws: --path-file needs a FILE name" >&2
            return 1
        end
        if not string match -q -- '/*' $path_file
            set path_file $caller_cwd/$path_file
        end
    end

    if test (count $argv) -lt 1; or test (count $argv) -gt 2
        echo "usage: gws [--path-file FILE] [--attach] <branch> [base-revision]" >&2
        return 1
    end

    set -l branch $argv[1]
    set -l revision ''
    if test (count $argv) -eq 2
        set revision $argv[2]
    end
    if set -q _flag_attach; and test -n "$revision"
        echo "gws: --attach starts from the existing branch; drop the base revision" >&2
        return 1
    end

    # The DIRECTORY cannot be the branch name: `jj workspace add` does not
    # create parent directories, so a branch with a slash (feat/zz) has no
    # usable path. Flatten it the way worktrunk names worktrees — feat/zz ->
    # feat-zz — and pass the raw branch as --name, so the workspace is still
    # looked up by BRANCH name and the seeded `jj workspace forget
    # {{ branch }}` keeps matching.
    set -l dir (string replace -a / - -- $branch)

    # find the wrapper: the nearest ancestor holding the directory jj repo
    set -l d (pwd)
    while test "$d" != "/"
        if test -d "$d/.jj/repo"
            break
        end
        set d (command dirname $d)
    end
    if not test -d "$d/.jj/repo"
        echo "gws: no jj directory repo found at or above cwd (run from inside a ginit'd repo)" >&2
        return 1
    end
    set -l wrapper $d
    # ws_path and not path: fish keeps $path as a mirror of PATH, so a local with
    # that name would shadow it for the length of everything below.
    set -l ws_path $wrapper/$dir

    if test -e $ws_path
        echo "gws: $ws_path already exists" >&2
        return 1
    end
    if not test -d $wrapper/main
        echo "gws: $wrapper/main (the full-sparse base workspace) not found" >&2
        return 1
    end

    # The directories are entered with `builtin cd`, and every borrowed program
    # is called through `command`. fish's function namespace belongs to the USER:
    # on this machine `cd` is a `ze` jumper that prints a page of errors and
    # returns without changing directory, so a plain `cd` here would run the add
    # from the wrong workspace (losing the sparse patterns main has) and leave the
    # shell outside the worktree it just announced as ready. The exceptions are
    # fish's own builtins (`set`, `test`, `string`, `printf`, …) and `wt`, which
    # on this machine is the user's fish stub and must run as such.

    # from main: full sparse inheritance + the new workspace starts at main's
    # position (or the given -r revision). A cd that failed here is the failure
    # this function exists to prevent: the add would run in the default workspace
    # at the wrapper, which is sparse-cleared, and make a workspace with the
    # wrong patterns while reporting success -- so the cd is checked.
    builtin cd $wrapper/main
    or return 1

    # A base revision is only worth anything if it is fresh (usually a remote
    # bookmark like main@origin), so fetch first — but never let a fetch decide
    # the outcome: offline, or in a repo with no remote, the add below still
    # does whatever the revision resolves to locally.
    if test -n "$revision"
        # bounded only when a bound is available: `timeout` is GNU coreutils
        # (often `gtimeout`), and may be missing entirely — neither case may
        # turn a SKIPPED fetch into a reported failure
        if command -q timeout
            command timeout 30 jj git fetch
        else if command -q gtimeout
            command gtimeout 30 jj git fetch
        else
            command jj git fetch
        end
        or echo "gws: could not fetch; $branch starts from $revision as it is" >&2
    end

    set -l start
    if set -q _flag_attach
        set start $branch
    else if test -n "$revision"
        set start $revision
    end
    # the `=` forms keep the name and the revision VALUES even when they start
    # with a dash, so `gws -- -flat` reaches jj instead of tripping the parser
    # (git will still refuse `-flat` as a branch name — see the checkout below)
    if test -n "$start"
        command jj workspace add --colocate $ws_path --name=$branch -r=$start
    else
        command jj workspace add --colocate $ws_path --name=$branch
    end
    or return 1

    # attach git HEAD to the branch (wt-friendly view): create it at the
    # workspace's HEAD, or — with --attach — land on the branch that exists
    if set -q _flag_attach
        command git -C $ws_path checkout -q $branch
    else
        command git -C $ws_path checkout -q -b $branch
    end
    or return 1

    # jj (not wt) created the worktree — run the post-start hooks manually
    wt -C $ws_path -y hook post-start

    # last thing before the cd, so a caller that captured FILE can rely on the
    # workspace being complete and cannot be left half-way by a later failure.
    # The write goes through tee, not a redirect: fish prints its own warning
    # for a failed redirection and cannot be quieted, and this is the one
    # failure that must not be mistaken for success (a caller with no path
    # cannot find the workspace we just made).
    if test -n "$path_file"
        if not printf '%s\n' $ws_path | command tee $path_file >/dev/null 2>&1
            echo "gws: could not write the path to $path_file" >&2
            return 1
        end
    end

    builtin cd $ws_path
    or return 1
    echo "gws: $ws_path ready (jj workspace '$branch', branch $branch attached, hooks run)"
    echo "     remove with: wt remove $branch  (the post-remove hook forgets the jj workspace)"
end
