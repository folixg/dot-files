#!/usr/bin/env bash
# flush the gpg-agent password cache
pid=$(pgrep gpg-agent)
if [ "$pid" ] ; then
  kill -SIGHUP "$pid"
fi
