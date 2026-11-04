function jws --description "Create a jj workspace on a branch, run its dojjo hooks, and report its path"
    # usage: jws [--path-file FILE] [--attach | --existing] <branch> [base-revision]
    #
    # The companion to gws for a wrapper the new-work flow actually drives, and
    # the ONE place dojjo is named. It exists because in a wrapper layout the
    # two obvious tools both let the flow down: worktrunk is a git worktree tool
    # and jj detaches HEAD in exactly these repos, and `djo switch` resolves the
    # shared .jj through `<workspace>/.jj/repo`'s relative text without resolving
    # it against the workspace, so it dies `PathNotFoundException` on its state
    # file -- sometimes after it has made the workspace and run the hooks, and
    # sometimes after it has made a directory holding only .git and .jj and run
    # none of them (both measured on 0.2.2), so neither its status nor the shape
    # it leaves behind can be trusted to say what happened. So:
    #
    #   * CREATION is jj's: `jj workspace add --name <branch> <wrapper>/<dir>`,
    #     run from <wrapper>/main so the new workspace inherits main's sparse
    #     patterns (the `default` workspace at the wrapper is sparse-cleared and
    #     must never be the context for an add), then `jj bookmark create`. A
    #     create that wanted a base revision is `-r <rev>` on the add.
    #   * HOOKS are dojjo's, and dojjo's alone: `djo hook post-start`, run inside
    #     the new workspace. dojjo exits 0 even when a hook fails, so a hook
    #     failure is reported by dojjo (one line and the log path on the pane)
    #     and is NOT a create failure -- the person still gets their tab.
    #   * The PATH is read back from `jj workspace list`, never parsed out of a
    #     tool's chatty stdout: a path handed to the tab has to be a path jj
    #     will still answer with, or the tab lands somewhere nobody meant.
    #
    # Three modes. No flag CREATES the workspace and a bookmark for it --
    # `jj workspace add [-r <base>]`, `jj bookmark create`, `jj bookmark track`
    # where origin names that branch. --attach starts from a bookmark that
    # already exists: the add is `-r <branch>` and no bookmark work follows,
    # because the new workspace gets a new commit on top of the branch and the
    # bookmark stays where it was -- what `gws` + `git checkout <branch>` left
    # behind. --existing SWITCHES to a workspace that already exists: it asks jj
    # for the rows, refuses a name they do not list, and creates nothing. A
    # create and an attach run the hooks; --existing runs neither them nor
    # dojjo at all.
    #
    # --path-file writes the workspace path to FILE as one line, for the tab,
    # which cannot follow the cd at the end.

    # options come first so that `--` can rescue a branch name starting with -
    argparse --name jws 'p/path-file=' a/attach x/existing -- $argv
    or return 1

    # The flags are parsed before anything cds, so this is still the caller's
    # cwd -- a relative FILE is relative to where they stood, not to
    # <wrapper>/main, which is only where the workspace is created from.
    set -l caller_cwd (pwd)
    set -l path_file ''
    if set -q _flag_path_file
        set path_file $_flag_path_file
        if test -z "$path_file"
            echo "jws: --path-file needs a FILE name" >&2
            return 1
        end
        if not string match -q -- '/*' "$path_file"
            set path_file "$caller_cwd/$path_file"
        end
    end

    if test (count $argv) -lt 1; or test (count $argv) -gt 2
        echo "usage: jws [--path-file FILE] [--attach | --existing] <branch> [base-revision]" >&2
        return 1
    end

    set -l branch $argv[1]
    set -l revision ''
    if test (count $argv) -eq 2
        set revision $argv[2]
    end

    # The two modes are alternatives in the interface (`[--attach | --existing]`),
    # and both start from something that already exists -- a bookmark for
    # --attach, a workspace for --existing. So asking for both is a caller's
    # mistake, and so is a base revision beside either, since it is a
    # contradiction rather than an override. Both refused here, before any of
    # the work, because the alternative is a workspace made on a base the person
    # did not mean, in a mode they did not choose.
    if set -q _flag_attach; and set -q _flag_existing
        echo "jws: --attach and --existing are different modes; pick one" >&2
        return 1
    end
    if set -q _flag_attach; or set -q _flag_existing
        if test -n "$revision"
            echo "jws: --attach and --existing start from what already exists; drop the base revision" >&2
            return 1
        end
    end

    # --path-file is proved writable HERE -- before a workspace exists, before
    # a bookmark does, before any hook runs, and before jj or dojjo is asked
    # anything at all. The write itself happens at the end, once the workspace
    # is complete; discovering an unwritable file there would leave a workspace
    # no tab can be handed, which is the one orphan this function must never
    # make. All three modes are covered: --existing writes the same file, just
    # later and after less work.
    #
    # The probe is `command touch`, immediately removed, rather than `test -w`
    # on the directory: the real write goes through `tee` into this very path,
    # and touch meets the same permission check that write will. Its own
    # complaint is suppressed so the refusal is the ONE line the caller reads --
    # fish prints nothing of its own for a failed `command`, so what is left is
    # jws's line and a non-zero status. A path file that is already there is only
    # asked about and never touched: its contents are the previous run's, and
    # this run replaces them at the end.
    if test -n "$path_file"
        if test -e "$path_file"
            if not test -w "$path_file"
                echo "jws: cannot write the path file: $path_file" >&2
                return 1
            end
        else
            if not command touch "$path_file" 2>/dev/null
                echo "jws: cannot write the path file: $path_file" >&2
                return 1
            end
            # The probe's file goes at once, so a refusal here and a refusal
            # later both leave nothing behind. `command rm` because on this
            # machine `rm` is a trash wrapper.
            command rm -f "$path_file"
        end
    end

    # find the wrapper: the nearest ancestor holding the directory jj repo.
    # `-d` and not `-e`: a plain colocated repo has a .jj/repo DIRECTORY too, but
    # it has no main beside it, and the next check refuses that by name rather
    # than this one refusing a shape that is merely unusual.
    set -l d $caller_cwd
    while test "$d" != "/"
        if test -d "$d/.jj/repo"
            break
        end
        set d (command dirname "$d")
    end
    if not test -d "$d/.jj/repo"
        echo "jws: no jj repo at or above cwd (run from inside a wrapper that has a main workspace)" >&2
        return 1
    end
    set -l wrapper $d

    # <wrapper>/main is the only notion of "where a workspace is created from"
    # this flow has: it is the workspace with the full sparse patterns and the
    # only one that sits beside the wrapper.
    if not test -d "$wrapper/main"
        echo "jws: $wrapper/main (the base workspace) not found" >&2
        return 1
    end

    # The workspace rows: ONE listing per mode, and `$rows` is the only place
    # this function asks jj which workspaces exist -- the refusal below reads
    # it, and so does the path the tab is handed.
    #
    # --existing reads them HERE, before any `cd`, before anything is created
    # and before dojjo is even looked for: the tab asks to switch to a
    # workspace the picker saw a moment ago, and that list can be stale. A
    # create would make a second workspace for a branch that already has one,
    # and dojjo asks `Create it? [y/N]` for a name it does not know, which in a
    # pane nobody can type into is an invisible hang. A create or an attach
    # reads the rows after it has made the workspace instead -- there is
    # nothing to read before that.
    #
    # -R at the wrapper rather than a `builtin cd` into <wrapper>/main: the
    # question is about the REPO's workspaces, so for a switch it has to be
    # answerable before this function has changed directory at all.
    # --ignore-working-copy because a post-start hook may still hold the lock.
    set -l rows
    if set -q _flag_existing
        set rows (command jj --ignore-working-copy -R "$wrapper" workspace list -T 'name ++ "\t" ++ root ++ "\n"')
    end

    # dojjo is checked before anything is created, not when it is time to run
    # the hooks: a workspace whose hooks never ran is a workspace the person has
    # to finish by hand, and the refuse-to-make-it moment is here, not there.
    # Only for the modes that run it -- --existing runs jj and nothing else, so
    # a machine with no dojjo can still switch.
    #
    # Everything in this block is the create-or-attach work. --existing has none
    # of it and falls through to the path read below.
    if not set -q _flag_existing
        if not command -q djo
            echo "jws: djo not found on PATH" >&2
            return 1
        end

        # The directories are entered with `builtin cd`, and every borrowed
        # program is called through `command`. fish's function namespace belongs
        # to the USER: on this machine `cd` is a `ze` jumper and `rm` is a
        # `trash` wrapper, so a plain `cd` here would run the add from the wrong
        # workspace -- losing the sparse patterns main has, and landing the
        # workspace outside the wrapper -- and leave the shell somewhere other
        # than the workspace it just announced as ready. The exceptions are
        # fish's own builtins (`set`, `test`, `string`, `printf`, …) and `djo`,
        # which is the program this function exists to run.
        builtin cd "$wrapper/main"
        or return 1

        # A create that was given a base revision refreshes first: that revision
        # is usually a remote bookmark, and dojjo never fetches -- there is no
        # `jj git fetch` in its source -- so if it does not happen here it does
        # not happen at all. 30 seconds because the pane is a terminal nobody can
        # type into: a fetch that wants a password must not swallow the tab. A
        # failed fetch is NOT a failed create: offline is worth one line, and the
        # workspace is then made from the revision as it resolves locally. A
        # revision only exists for a create -- the base-revision guard near the
        # top refuses one beside --attach or --existing.
        #
        # `command timeout` and not `timeout`: the bound is a borrowed program
        # like any other, and gtimeout is the form macOS's coreutils installs.
        if test -n "$revision"
            if command -q timeout
                command timeout 30 jj git fetch
            else if command -q gtimeout
                command gtimeout 30 jj git fetch
            else
                command jj git fetch
            end
            or echo "jws: could not fetch; $branch starts from $revision as it is" >&2
        end

        # The DIRECTORY cannot be the branch name: `jj workspace add` does not
        # create parent directories, so a branch with a slash (feat/x) has no
        # usable path. Flatten it the way gws names worktrees -- feat/x ->
        # feat-x -- and pass the raw branch as --name, so the workspace is still
        # looked up by BRANCH name, which is what the picker, the done flow and
        # the tab all use.
        set -l dir (string replace -a / - -- "$branch")

        # Two names on purpose: `dest` is the directory this call is about to
        # make, and `ws_path` (set further down) is what jj answers with
        # afterwards -- the path the tab is handed is jj's answer, not this
        # function's guess. Neither is called `path`: fish keeps $path as a
        # mirror of PATH, and a local with that name would shadow it for the
        # length of everything below.
        set -l dest "$wrapper/$dir"

        # A destination that is already there is refused, never adopted: two
        # branches can sanitise to one directory (feat/x and feat-x both want
        # feat-x), and adopting it would put this branch inside somebody else's
        # workspace.
        if test -e "$dest"
            echo "jws: $dest already exists" >&2
            return 1
        end

        # the `=` forms keep the name and the revision VALUES even when they
        # start with a dash, so `jws -- -flat` reaches jj instead of tripping its
        # parser. An attach passes the BRANCH as the revision and nothing else:
        # the bookmark is the revset, the new working copy is a new commit on top
        # of it, and no bookmark work follows -- `jj bookmark create` would fail
        # on the name that is already there, and a move would rewrite the branch
        # the attach borrowed.
        if set -q _flag_attach
            command jj workspace add --name="$branch" "$dest" "-r=$branch"
        else if test -n "$revision"
            command jj workspace add --name="$branch" "$dest" "-r=$revision"
        else
            command jj workspace add --name="$branch" "$dest"
        end
        or return 1

        # From inside the new workspace, so the bookmark and everything after it
        # are this workspace's.
        builtin cd "$dest"
        or return 1

        # jj creates no bookmark with a workspace, and the branch named here is
        # what every other part of the flow looks the workspace up by. An attach
        # has its bookmark already, so this is a CREATE's step only.
        if not set -q _flag_attach
            command jj bookmark create "$branch" -r @
            or return 1

            # A remote branch of the same name is worth tracking, and its
            # absence is not a failure: most branches this makes are new, and
            # dojjo never fetches, so `origin` knowing the name is the exception
            # rather than the rule.
            command jj bookmark track "$branch@origin" 2>/dev/null
            or true
        end

        # dojjo runs the post-start hooks here, in the new workspace and nowhere
        # else -- for an attach as much as for a create: whichever way the
        # workspace was started, the hooks are what make it usable. Its output is
        # the pane's -- including a failing hook, which dojjo prints with the log
        # path and exits 0 for -- so the status is deliberately not carried into
        # this function's: a hook failure is dojjo's to report.
        command djo hook post-start

        # The rows are read now, after the workspace exists, because they are
        # what gives the tab its path -- the same reading, the same single
        # consumer, whichever mode produced them.
        set rows (command jj --ignore-working-copy -R "$wrapper" workspace list -T 'name ++ "\t" ++ root ++ "\n"')
    end

    # The path comes from jj and from nowhere else, out of the rows read above.
    # A row is <name>\t<root>, and only an EXACT name match counts: `feat/x` and
    # `feat-x` must never be mistaken for each other here, or the tab lands in
    # the wrong workspace. This is also the ONE refusal for a name jj does not
    # list -- the switch's rows were read before any `cd` or any dojjo call, so
    # a stale name still cannot reach either.
    set -l ws_path ''
    for row in $rows
        set -l fields (string split \t -- $row)
        if test "$fields[1]" = "$branch"
            set ws_path "$fields[2]"
            break
        end
    end
    if test -z "$ws_path"
        echo "jws: jj lists no workspace named $branch" >&2
        return 1
    end

    # The write happens after the workspace is complete and through `tee`, not a
    # redirect: fish prints its own warning for a failed redirection and cannot
    # be quieted, and this is the one failure that must not be mistaken for
    # success -- a caller with no path cannot find the workspace we just made.
    if test -n "$path_file"
        # The probe above already proved this can be written; it is kept as its
        # own refusal anyway, because a file can be taken away between the two
        # moments and a caller with no path cannot find the workspace.
        if not printf '%s\n' "$ws_path" | command tee "$path_file" >/dev/null 2>&1
            echo "jws: could not write the path to $path_file" >&2
            return 1
        end
    end

    builtin cd "$ws_path"
    or return 1
    # --existing ran no hooks, so its line does not claim any: the two modes
    # are two different promises to the person reading the pane.
    if set -q _flag_existing
        echo "jws: $ws_path ready (jj workspace '$branch', switched)"
    else
        echo "jws: $ws_path ready (jj workspace '$branch', hooks run)"
    end
    echo "     remove with: djo remove $branch -y, or ctrl+space>d"
end
