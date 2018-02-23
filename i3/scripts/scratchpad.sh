#!/usr/bin/env bash
xterm -xrm 'XTerm.vt100.allowTitleOps: false' -T 'i3-scratchpad' \
  -e vim -c 'set ft=markdown' -c 'set noswapfile' /tmp/scratchpad &
sleep 0.2
i3-msg [title="i3-scratchpad"] move scratchpad
