# Vivaldi post-update restore function
# Source this file or add to ~/.config/fish/config.fish:
#   source ~/vivaldi.fish
#
# Then run after any Vivaldi update:
#   vivaldi_restore

function vivaldi_restore
    # ── Locate the current Vivaldi resources directory ──────────────────────
    set vivaldi_res (find /Applications/Vivaldi.app \
        -name "window.html" \
        -path "*/vivaldi/window.html" \
        2>/dev/null | head -1 | xargs -I{} dirname {})

    if test -z "$vivaldi_res"
        echo "❌  Could not find Vivaldi resources directory."
        echo "    Is Vivaldi installed at /Applications/Vivaldi.app?"
        return 1
    end

    echo "📁  Resources: $vivaldi_res"

    # ── Copy custom.js ───────────────────────────────────────────────────────
    set src_js ~/css/custom.js

    if not test -f $src_js
        echo "❌  Source not found: $src_js"
        echo "    Save your custom.js there first."
        return 1
    end

    cp $src_js $vivaldi_res/custom.js
    and echo "✅  Copied custom.js"
    or begin
        echo "❌  Failed to copy custom.js (permission error?)"
        echo "    Try: sudo cp $src_js $vivaldi_res/custom.js"
        return 1
    end

    # ── Patch window.html ────────────────────────────────────────────────────
    set window_html $vivaldi_res/window.html

    if grep -q "custom.js" $window_html
        echo "✅  window.html already patched — nothing to do"
    else
        # Back up before touching
        cp $window_html $window_html.bak
        echo "📄  Backed up window.html → window.html.bak"

        # Inject script tag before </body>
        sed -i '' 's|</body>|<script src="custom.js"></script>\n</body>|' $window_html
        and echo "✅  Patched window.html"
        or begin
            echo "❌  Failed to patch window.html"
            return 1
        end
    end

    # ── Done ─────────────────────────────────────────────────────────────────
    echo ""
    echo "✅  All done. Restart Vivaldi to apply changes."
    echo "    (The CSS at ~/css/dia-vivaldi.css is already wired up via settings — no action needed.)"
end
