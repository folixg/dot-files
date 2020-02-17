# Defined in /tmp/fish.Z8iviy/gpg-key-unlock.fish @ line 1
function gpg-key-unlock
    set -l gpg_bin /usr/bin/gpg
    if test -f /usr/bin/gpg2
        set gpg_bin /usr/bin/gpg2
    end
    echo "" | $gpg_bin -s &> /dev/null
end
