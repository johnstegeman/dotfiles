function _tide_item_vcs
    # Try jj first (mirrors starship's vcs order = ["jujutsu", "git"]).
    # Falls back to tide's built-in git item when not in a jj repo.
    if command -q jj && jj root --ignore-working-copy --quiet &>/dev/null
        _tide_item_jj
    else
        _tide_item_git
    end
end
