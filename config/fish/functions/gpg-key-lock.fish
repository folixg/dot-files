# Defined in /tmp/fish.Iex8bR/gpg-key-lock.fish @ line 2
function gpg-key-lock
    set -l pid (pgrep gpg-agent)
    if test -n $pid
        kill -SIGHUP $pid
    end
end
