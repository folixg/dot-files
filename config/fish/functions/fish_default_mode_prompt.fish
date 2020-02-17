# Defined in /tmp/fish.qG2AKE/fish_default_mode_prompt.fish @ line 2
function fish_default_mode_prompt --description 'Display the default mode for the prompt'
    # Do nothing if not in vi mode
    if test "$fish_key_bindings" = "fish_vi_key_bindings"
        or test "$fish_key_bindings" = "fish_hybrid_key_bindings"
        switch $fish_bind_mode
            case default
                set_color --bold --background red white
                echo '[NORMAL]'
            case replace_one
                set_color --bold --background green white
                echo '[REPLACE]'
            case replace
                set_color --bold --background cyan white
                echo '[REPLACE]'
            case visual
                set_color --bold --background magenta white
                echo '[VISUAL]'
        end
        set_color normal
        echo -n ''
    end
end
