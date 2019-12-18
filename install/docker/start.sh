#!/bin/bash

set_account_ids() {
  USER_UID=${USER_UID:-1000}
  USER_GID=${USER_GID:-1000}
  groupmod -o -g "$USER_GID" folix >/dev/null 2>&1
  usermod -o -u "$USER_UID" folix >/dev/null 2>&1
}

set_account_ids

chown -R folix:folix /home/folix

exec gosu folix:folix /usr/bin/tmux
