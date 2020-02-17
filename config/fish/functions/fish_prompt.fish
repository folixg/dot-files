function fish_prompt --description 'Write out the prompt'

    set -l normal (set_color normal)

    # Color the prompt differently when we're root
    set -l color_cwd $fish_color_cwd
    set -l prefix
    set -l suffix '>'
    if contains -- $USER root toor
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix '#'
    end

    # If we're running via SSH, show user@host.
    set -l user_host
    if set -q SSH_TTY
        set user_host "$USER"(prompt_hostname)":"
    end

    echo -n -s $user_host (set_color $color_cwd) (prompt_pwd) $normal $suffix " "
end
