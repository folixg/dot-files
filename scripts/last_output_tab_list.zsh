# Use alt-e or esc-e to tab-select through the output of a previous
# command.
# Use-case: ls or find was the previous command, and you now want to
# edit one of them. No need for mouse copy-pasta.
#
# https://www.zsh.org/mla/users/2004/msg00893.html

_jh-prev-result () {
    hstring=$(eval `fc -l -n -1`)
    set -A hlist ${(@s/
/)hstring}
    compadd - ${hlist}
}

zle -C jh-prev-comp menu-complete _jh-prev-result
bindkey '\ee' jh-prev-comp

