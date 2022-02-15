# Defined in /tmp/fish.UaEAGa/ssh.fish @ line 1
function ssh
  if test -z "$TMUX"
    /usr/bin/ssh -t $argv "tmux new -A -s ssh 2>/dev/null || fish 2>/dev/null || zsh 2>/dev/null || bash"
  else 
    /usr/bin/ssh -t $argv "fish 2>/dev/null || zsh 2>/dev/null || bash"
  end
end
