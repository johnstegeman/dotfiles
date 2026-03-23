function _tide_item_jj
    # Only run if jj is installed and we're inside a jj repo
    command -q jj; or return
    jj root --ignore-working-copy --quiet &>/dev/null; or return

    # ── Single jj log call ────────────────────────────────────────────────
    # Fields (pipe-delimited): change_id | commit_id | bookmarks | state_flags
    # Using "|" as delimiter — unlikely to appear in any of these fields.
    set -l raw (jj log -r @ \
        --no-graph \
        --ignore-working-copy \
        --color never \
        --limit 1 \
        -T '
            change_id.shortest(6)
                ++ "|" ++ commit_id.shortest(6)
                ++ "|" ++ separate(" ", bookmarks)
                ++ "|" ++ concat(
                    if(conflict,  "💥"),
                    if(divergent, "🚧"),
                    if(hidden,    "👻"),
                    if(immutable, "🔒"),
                )
        ' 2>/dev/null)
    test -z "$raw"; and return

    set -l parts    (string split '|' -- $raw)
    set -l change   (string trim $parts[1])  # e.g. "vzpt"
    set -l commit   (string trim $parts[2])  # e.g. "abc1"
    set -l bookmark (string trim $parts[3])  # e.g. "main" (empty if not on one)
    set -l state    (string trim $parts[4])  # emoji flags, may be empty

    # ── Closest ancestor bookmark (when not directly on one) ──────────────
    # User's command: jj log -r 'heads(::@ & bookmarks())' --no-graph -T bookmarks
    if test -z "$bookmark"
        set bookmark (jj log \
            -r 'heads(::@ & bookmarks())' \
            --no-graph \
            --ignore-working-copy \
            --color never \
            -T 'separate(" ", bookmarks)' 2>/dev/null | string trim)
        # Prefix with ↑ to indicate we're ahead of the bookmark
        test -n "$bookmark"; and set bookmark "↑$bookmark"
    end

    # ── File-level status (jj st) ─────────────────────────────────────────
    set -l file_counts (jj st --ignore-working-copy 2>/dev/null | awk '
        BEGIN {a=0;d=0;m=0}
        /^A / {a++} /^D / {d++} /^M / {m++} /^R / {m++} /^C / {a++}
        END {print(a,d,m)}')
    set -l fparts (string split ' ' -- $file_counts)
    set -l fadd (string trim $fparts[1])
    set -l fdel (string trim $fparts[2])
    set -l fmod (string trim $fparts[3])

    # ── Diff metrics ──────────────────────────────────────────────────────
    # `jj diff --stat` prints a git-style stat summary; parse the last line:
    #   "3 files changed, 12 insertions(+), 4 deletions(-)"
    # Either count may be absent when zero (e.g. "1 file changed, 5 deletions(-)").
    set -l added   0
    set -l deleted 0
    set -l stat_summary (jj diff --ignore-working-copy --stat 2>/dev/null | tail -1)
    if test -n "$stat_summary"
        set -l a (string match -rg '(\d+) insertion' -- $stat_summary)
        set -l d (string match -rg '(\d+) deletion'  -- $stat_summary)
        test -n "$a"; and set added   $a
        test -n "$d"; and set deleted $d
    end

    # ── Render ────────────────────────────────────────────────────────────
    # Rose Pine palette (hex, no #)
    set -l c_foam  9ccfd8  # bookmarks  — matches starship git_branch fg:foam
    set -l c_iris  c4a7e7  # change_id  — matches starship directory fg:iris
    set -l c_gold  f6c177  # modified   — rose pine gold, distinct from add/del
    set -l c_pine  31748f  # added      — matches starship git_status staged fg:pine
    set -l c_love  eb6f92  # deleted    — matches starship git_status deleted fg:love
    set -l c_text  e0def4  # commit_id  — matches starship text color

    # file counts (shown first — the "state" of the working copy)
    if test "$fadd" -gt 0 2>/dev/null
        set_color $c_pine
        echo -ns " +$fadd"
    end
    if test "$fmod" -gt 0 2>/dev/null
        set_color $c_gold
        echo -ns " ~$fmod"
    end
    if test "$fdel" -gt 0 2>/dev/null
        set_color $c_love
        echo -ns " -$fdel"
    end

    # commit_id (muted text — secondary info)
    set_color $c_text
    echo -ns " $commit"

    #  + change_id (iris — jj's own change tracking)
    set_color $c_iris
    echo -ns " $change"

    # bookmark (foam — matches starship git_branch color)
    if test -n "$bookmark"
        set_color $c_foam
        echo -ns " $bookmark"
    end

    # state flags (emoji carry their own visual weight, no color needed)
    if test -n "$state"
        set_color normal
        echo -ns " $state"
    end

    # +added / -deleted metrics (only show non-zero values)
    if test "$added" -gt 0 2>/dev/null
        set_color $c_pine
        echo -ns " +$added"
    end
    if test "$deleted" -gt 0 2>/dev/null
        set_color $c_love
        echo -ns " -$deleted"
    end

    set_color normal
end
