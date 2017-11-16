#!/usr/bin/env bash

# the only valid argument is --suspend, which means we will suspend and lock
if [ "$1" == "--suspend" ]; then
  suspend=1
else
  suspend=0
fi

# if xautolock is running, disable it, before locking to avoid double locks
if [ "$(pgrep xautolock)" ] ; then
  xautolock -disable
fi

# pause music player if it is playing
#
# variable to store which player was paused
paused_player="none"
# first check if cmus is playing
if cmus-remote -Q | grep -q "playing" ; then
  cmus-remote --pause
  paused_player="cmus"
# if playerctl is installed, check for other players
elif [ "$(which playerctl)" ] ; then
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
  if [ $suspend -eq 1 ] ; then
    i3lock -c 2f343f -i ~/.i3/images/locked.png -t && systemctl suspend
  else
    i3lock -n -c 2f343f -i ~/.i3/images/locked.png -t
  fi
else
  # fancy lock screen https://git.fleshless.org/misc/tree/i3lock-extra
  umask 0077 # temp files are only accessible for the user
  tmpdir="/run/user/$UID/fancy_lock"
  if ! [ -d $tmpdir ] ; then
   mkdir "$tmpdir" || exit 1
  fi
  # take screenshot
  scrot "$tmpdir/lockscreen.png"
  ## pixelize and blur screenshot
  convert "$tmpdir/lockscreen.png" "-scale" "10%" "-scale" "1000%" "-blur" \
    "4x8" "$tmpdir/lockscreen.png" 
  # overlay with lock symbol
  if [[ $(xrandr | grep -c -w connected) -eq 2 ]] ; then
    # dual screen
    convert "-gravity" "center" "-composite" "-matte" "$tmpdir/lockscreen.png" \
      "$HOME/.i3/images/dualscreen_locked.png" "$tmpdir/lockscreen.png"
  else
    convert "-gravity" "center" "-composite" "-matte" "$tmpdir/lockscreen.png" \
      "$HOME/.i3/images/locked.png" "$tmpdir/lockscreen.png"
  fi 
  # perform lock
  if [ $suspend -eq 1 ] ; then
    i3lock -i "$tmpdir/lockscreen.png" && systemctl suspend
  else
    i3lock -n -i "$tmpdir/lockscreen.png"
  fi
fi
# resume music player if it was paused on lock (unless system was suspended)
if [ $suspend -eq 0 ] ; then
  if [ "$paused_player" == "cmus" ] ; then
    cmus-remote --play
  elif [ "$paused_player" != "none" ] ; then
   playerctl --player="$paused_player" play
  fi
fi

# resume dunst notifications
killall -SIGUSR2 dunst

# enable xautolock again
if [ "$(pgrep xautolock)" ] ; then
  xautolock -enable
fi
