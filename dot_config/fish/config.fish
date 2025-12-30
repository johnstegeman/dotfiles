status is-login; and begin

end

status is-interactive; and begin

    # Add paths only if directories exist
    test -d /opt/homebrew/bin; and fish_add_path /opt/homebrew/bin
    test -d /opt/homebrew/opt/trash-cli/bin; and fish_add_path /opt/homebrew/opt/trash-cli/bin
    test -d /Users/jstegeman/.swiftly/bin; and fish_add_path /Users/jstegeman/.swiftly/bin
    test -d ~/bin; and fish_add_path ~/bin
    test -d ~/.cargo/bin; and fish_add_path ~/.cargo/bin

    fish_config theme choose "Rosé Pine"

    set -xg VIRTUAL_ENV_DISABLE_PROMPT yes
    set -gx LEADR_CONFIG_DIR ~/.config/leadr

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

    if using leadr
        leadr --fish | source
    end

    if test "$TERM" != dumb
        and using oh-my-posh
        #and using starship
        
        #starship init fish | source
        #enable_transience
        oh-my-posh init fish --config $HOME/.config/oh-my-posh/steggy-rosepine.toml | source

    end

    if using atuin
        atuin init fish --disable-ctrl-r | source
    end

    if using hx
        set -gx EDITOR hx
    end

    if using carapace
        set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
        carapace _carapace | source
    end

end