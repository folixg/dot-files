#!/usr/bin/env bash

# if xautolock is running, use it
if [ "$(pgrep xautolock)" ] ; then
  xautolock -locknow
# else use lock script directly
else
  ~/.i3/lock/lock.sh
fi
