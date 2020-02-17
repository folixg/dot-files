# Defined in /tmp/fish.UaEAGa/ssh.fish @ line 1
function ssh
    /usr/bin/ssh -t $argv "tmux new 2>/dev/null || zsh 2>/dev/null || bash"
end
