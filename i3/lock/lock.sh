#!/usr/bin/env bash

# if playerctl is installed, pause music player if it is playing
if [ "$(which playerctl)" ] ; then
  playerctl="1"
  # variable to store which player was paused
  paused_player="none"
  # get list of running music players
  read -a players <<< $(playerctl --list-all)
  # check whether a player is playing
  for player in "${players[@]}"
  do
   if [ "$(playerctl --player="$player" status)" = "Playing" ] ; then
     # and pause it
     playerctl --player="$player" pause
     paused_player=$player
   fi
  done
fi

# pause dunst notifications
killall -SIGUSR1 dunst

# if the tools for the fancy lock screen (scrot, convert) are not available
# use a simple lock screen
if [[ ! ($(which scrot) && $(which convert)) ]] ; then
  i3lock -c 2f343f -i ~/.i3/lock/locked.png -t
else
  # fancy lock screen https://git.fleshless.org/misc/tree/i3lock-extra
  if [[ $(xrandr | grep -c -w connected) -eq 2 ]] ; then
    # dual screen
    ~/.i3/lock/i3lock-extra.sh -s -b -p -o ~/.i3/lock/dualscreen_locked.png
  else
    # single screen
    ~/.i3/lock/i3lock-extra.sh -s -b -p -o ~/.i3/lock/locked.png
  fi
fi

if [[ $playerctl == "1" ]] ; then
  # resume play of the player we paused
  if [ "$paused_player" != "none" ] ; then
    playerctl --player="$paused_player" play
  fi
fi

# resume dunst notifications
killall -SIGUSR2 dunst
