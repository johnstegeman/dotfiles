status is-login; and begin

end

status is-interactive; and begin

    # Add paths only if directories exist
    test -d /opt/homebrew/bin; and /opt/homebrew/bin/brew shellenv | source
    test -d /opt/homebrew/opt/trash-cli/bin; and fish_add_path /opt/homebrew/opt/trash-cli/bin
    test -d /Users/jstegeman/.swiftly/bin; and fish_add_path /Users/jstegeman/.swiftly/bin
    test -d ~/bin; and fish_add_path ~/bin
    test -d ~/.cargo/bin; and fish_add_path ~/.cargo/bin

    fish_config theme choose "Ayu Dark"

    # Prompt: starship, configured in ~/.config/starship.toml with the Ayu Dark palette.
    # enable_transience collapses finished prompts; starship_transient_prompt_func keeps the
    # transient ❯ in Ayu cyan (red after a failed command).
    if using starship
        starship init fish | source
        enable_transience
    end

    set -xg VIRTUAL_ENV_DISABLE_PROMPT yes

    abbr -a -- - 'cd -'

    if using uv
        uv generate-shell-completion fish | source
    end

    if using fzf
        fzf --fish | source
    end

    if using atuin
        atuin init fish --disable-ctrl-r | source
    end

    if using nvim
        set -gx EDITOR nvim
    end

    if using haven
       haven completions fish --cmd-name hv | source
    end

    if using carapace
        set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
        carapace _carapace | source
    end

    if using swiftly
       source "/Users/jstegeman/.swiftly/env.fish"
    end

end

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/jstegeman/.lmstudio/bin
# End of LM Studio CLI section

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
