# Only execute this file once per shell.
set -q __fish_home_manager_config_sourced; and exit
set -g __fish_home_manager_config_sourced 1

#source /nix/store/9ynbk6xyz1vg7hn6s3k3439rdr0171by-hm-session-vars.fish

if using pazi
    pazi init fish | source
end

status is-login; and begin

    fish_add_path /opt/homebrew/bin # need different one for linux
    fish_add_path /opt/homebrew/opt/trash-cli/bin

    fish_config theme choose solarized_osaka_dark

    # set -xg DIRENV_LOG_FORMAT ''
    set -xg VIRTUAL_ENV_DISABLE_PROMPT yes

    abbr -a -- - 'cd -'

    if test -e ~/.jenv/bin
        fish_add_path ~/.jenv/bin
        jenv init - | source
    end

    if using uv
        uv generate-shell-completion fish | source
    end

end

status is-interactive; and begin

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

end