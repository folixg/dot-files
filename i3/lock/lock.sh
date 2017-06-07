#!/usr/bin/env bash

# variable to store which player was paused
paused_player="none"
# get list of running music players
read -a players <<< $(playerctl --list-all)
# check whether a player is playing
for player in "${players[@]}"
do
  if [ "$(playerctl --player=$player status)" = "Playing" ] ; then
    # and pause it
    playerctl --player=$player pause
    paused_player=$player
    echo $paused_player
  fi
done

#i3lock -i ~/Firefox_wallpaper.png -t -f

# fancy lock screen https://git.fleshless.org/misc/tree/i3lock-extra
# single screen
#~/.i3/lock/i3lock-extra.sh -s -b -p -o ~/.i3/lock/locked.png
## dual screen
~/.i3/lock/i3lock-extra.sh -s -b -p -o ~/.i3/lock/dualscreen_locked.png

# resume play of the player we paused
if [ "$paused_player" != "none" ] ; then
  playerctl --player=$paused_player play
fi
