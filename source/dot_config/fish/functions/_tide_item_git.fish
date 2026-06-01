function _tide_item_git
    command -q git; or return

    git rev-parse --git-dir --is-inside-git-dir 2>/dev/null | read -fL gdir in_gdir
    or return

    set -l git_args
    if test "$in_gdir" = true
        set git_args -C $gdir/..
    end

    set -l status_lines (git $git_args --no-optional-locks status --porcelain=v2 --branch --show-stash 2>/dev/null)
    or return

    set -l oid
    set -l branch
    set -l upstream
    set -l ahead 0
    set -l behind 0
    set -l conflicted 0
    set -l added_files 0
    set -l modified_files 0
    set -l deleted_files 0
    set -l untracked_files 0

    for line in $status_lines
        switch $line
            case '# branch.oid *'
                set oid (string replace '# branch.oid ' '' -- $line)
            case '# branch.head *'
                set branch (string replace '# branch.head ' '' -- $line)
            case '# branch.upstream *'
                set upstream (string replace '# branch.upstream ' '' -- $line)
            case '# branch.ab *'
                set -l ab_parts (string split ' ' -- (string replace '# branch.ab ' '' -- $line))
                if test (count $ab_parts) -ge 2
                    set ahead (string replace '+' '' -- $ab_parts[1])
                    set behind (string replace '-' '' -- $ab_parts[2])
                end
            case 'u *'
                set conflicted (math $conflicted + 1)
            case '? *'
                set untracked_files (math $untracked_files + 1)
            case '1 *' '2 *'
                set -l parts (string split ' ' -- $line)
                set -l xy $parts[2]

                if string match -qr 'D' -- $xy
                    set deleted_files (math $deleted_files + 1)
                else if string match -qr 'A' -- $xy
                    set added_files (math $added_files + 1)
                else if string match -qr '[MTRC]' -- $xy
                    set modified_files (math $modified_files + 1)
                end
        end
    end

    set -l sha unborn
    if test -n "$oid"
        if test "$oid" = '(initial)'
            set sha unborn
        else if string match -qr '^[0]+$' -- $oid
            set sha unborn
        else
            set sha (string sub -s 1 -l 6 -- $oid)
        end
    end

    set -l branch_display $branch
    if test -z "$branch_display"
        set branch_display detached
    else if test "$branch_display" = '(detached)'
        set branch_display detached
    end

    set -l tracking_display
    if test -n "$upstream"
        if string match -qr '^origin/' -- $upstream
            set tracking_display (string replace -r '^origin/' '' -- $upstream)
        else
            set tracking_display $upstream
        end
    end

    if test -n "$branch_display"
        set branch_display (string shorten -"$tide_git_truncation_strategy"m$tide_git_truncation_length -- $branch_display)
    end

    if test -n "$tracking_display"
        set tracking_display (string shorten -"$tide_git_truncation_strategy"m$tide_git_truncation_length -- $tracking_display)
    end

    # Mirror Tide's operation detection so in-progress workflows still surface.
    set -l operation
    set -l step
    set -l total_steps

    if test -d $gdir/rebase-merge
        if not path is -v $gdir/rebase-merge/{msgnum,end}
            read -f step <$gdir/rebase-merge/msgnum
            read -f total_steps <$gdir/rebase-merge/end
        end

        if test -f $gdir/rebase-merge/interactive
            set operation rebase-i
        else
            set operation rebase-m
        end
    else if test -d $gdir/rebase-apply
        if not path is -v $gdir/rebase-apply/{next,last}
            read -f step <$gdir/rebase-apply/next
            read -f total_steps <$gdir/rebase-apply/last
        end

        if test -f $gdir/rebase-apply/rebasing
            set operation rebase
        else if test -f $gdir/rebase-apply/applying
            set operation am
        else
            set operation am/rebase
        end
    else if test -f $gdir/MERGE_HEAD
        set operation merge
    else if test -f $gdir/CHERRY_PICK_HEAD
        set operation cherry-pick
    else if test -f $gdir/REVERT_HEAD
        set operation revert
    else if test -f $gdir/BISECT_LOG
        set operation bisect
    end

    set -l stat_summary
    if test "$sha" = unborn
        set stat_summary (git $git_args --no-optional-locks diff --cached --shortstat 2>/dev/null)
    else
        set stat_summary (git $git_args --no-optional-locks diff --shortstat HEAD 2>/dev/null)
    end

    set -l insertions 0
    set -l deletions 0
    if test -n "$stat_summary"
        set -l added_lines (string match -rg '([0-9]+) insertion' -- $stat_summary)
        set -l deleted_lines (string match -rg '([0-9]+) deletion' -- $stat_summary)

        test -n "$added_lines"; and set insertions $added_lines
        test -n "$deleted_lines"; and set deletions $deleted_lines
    end

    set -l c_added $tide_git_color_staged
    set -l c_modified $tide_git_color_dirty
    set -l c_deleted $tide_git_color_conflicted
    set -l c_untracked $tide_git_color_untracked
    set -l c_branch $tide_git_color_branch
    set -l c_tracking $tide_git_color_upstream

    if test "$conflicted" -gt 0
        set_color $c_deleted
        echo -ns " !$conflicted"
    end

    if test "$added_files" -gt 0
        set_color $c_added
        echo -ns " +$added_files"
    end

    if test "$untracked_files" -gt 0
        set_color $c_untracked
        echo -ns " ?$untracked_files"
    end

    if test "$modified_files" -gt 0
        set_color $c_modified
        echo -ns " ~$modified_files"
    end

    if test "$deleted_files" -gt 0
        set_color $c_deleted
        echo -ns " -$deleted_files"
    end

    set_color normal
    echo -ns " $sha"

    if test -n "$branch_display"
        set_color $c_branch
        echo -ns " $branch_display"
    end

    if test -n "$tracking_display"
        set_color $c_tracking
        echo -ns " ↑$tracking_display"
    end

    if test "$ahead" -gt 0 2>/dev/null
        set_color $c_tracking
        echo -ns " ⇡$ahead"
    end

    if test "$behind" -gt 0 2>/dev/null
        set_color $c_tracking
        echo -ns " ⇣$behind"
    end

    if test -n "$operation"
        set_color normal
        echo -ns " $operation"

        if test -n "$step"
            if test -n "$total_steps"
                echo -ns " $step/$total_steps"
            end
        end
    end

    if test "$insertions" -gt 0 2>/dev/null
        set_color $c_added
        echo -ns " +$insertions"
    end

    if test "$deletions" -gt 0 2>/dev/null
        set_color $c_deleted
        echo -ns " -$deletions"
    end

    set_color normal
end
