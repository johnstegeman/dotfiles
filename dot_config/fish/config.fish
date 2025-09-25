status is-login; and begin

end

status is-interactive; and begin

    fish_add_path /opt/homebrew/bin # need different one for linux
    fish_add_path /opt/homebrew/opt/trash-cli/bin

    fish_config theme choose solarized_osaka_dark

    set -xg VIRTUAL_ENV_DISABLE_PROMPT yes

    abbr -a -- - 'cd -'

    if using uv
        uv generate-shell-completion fish | source
    end

    if using fzf
        fzf --fish | source
    end

    if using zoxide
        zoxide init fish | source
    end

    if test "$TERM" != dumb
        and using starship
        
        starship init fish | source
        enable_transience

    end

    if using atuin
        atuin init fish --disable-ctrl-r | source
    end

    if using hx
        set -gx EDITOR hx
    end

end

set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
carapace _carapace | source