#!/usr/bin/env bash
# sign an empty message with gpg2, in order to trigger pinentry, when the
# default key is locked. I use this to unlock the key manually for use with
# enigmail, as i found no other way to use enigmail in combination with
# pinentry-curses.
echo "" | gpg2 -s &>/dev/null
