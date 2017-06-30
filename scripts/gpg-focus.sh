#!/usr/bin/env bash
pid=$(pgrep pinentry-curses)
if [ "$pid" ] ; then
  kill "$pid"
fi
echo "UPDATESTARTUPTTY" | gpg-connect-agent 1>/dev/null
