function starship_transient_prompt_func --description 'Transient prompt: Ayu cyan ❯, red after a failed command'
    set -l status_code 0
    for arg in $argv
        if string match -q -- '--status=*' $arg
            set status_code (string replace -- '--status=' '' $arg)
        end
    end

    if test "$status_code" = 0
        set_color 39BAE6 # Ayu cyan
    else
        set_color F07178 # Ayu red
    end
    printf '❯ '
    set_color normal
end
