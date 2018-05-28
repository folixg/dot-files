#!/usr/bin/env bash

SPOTIFY="org.mpris.MediaPlayer2.spotify"
MEDIAPLAYER="/org/mpris/MediaPlayer2"
GET_PROPERTIES="org.freedesktop.DBus.Properties.Get"
PLAYER="org.mpris.MediaPlayer2.Player"

# This function is taken from  https://gist.github.com/wandernauta/6800547
function sp-metadata {
  # Prints the currently playing track in a parseable format.

  dbus-send                                                                   \
  --print-reply                                  `# We need the reply.`       \
  --dest=$SPOTIFY                                                             \
  $MEDIAPLAYER                                                                \
  $GET_PROPERTIES                                                             \
  string:"$PLAYER" string:'Metadata'                                          \
  | grep -Ev "^method"                           `# Ignore the first line.`   \
  | grep -Eo '("(.*)")|(\b[0-9][a-zA-Z0-9.]*\b)' `# Filter interesting fiels.`\
  | sed -E '2~2 a|'                              `# Mark odd fields.`         \
  | tr -d '\n'                                   `# Remove all newlines.`     \
  | sed -E 's/\|/\n/g'                           `# Restore newlines.`        \
  | sed -E 's/(xesam:)|(mpris:)//'               `# Remove ns prefixes.`      \
  | sed -E 's/^"//'                              `# Strip leading...`         \
  | sed -E 's/"$//'                              `# ...and trailing quotes.`  \
  | sed -E 's/"+/|/'                             `# Regard "" as seperator.`  \
  | sed -E 's/ +/ /g'                            `# Merge consecutive spaces.`\
  | sed -E 's/\"/\\\"/g'                         `# Escape quotes for JSON.`
}

i3status -c ~/.i3/i3status.conf | while :
do
  read line
  if [ "$line" == '{"version":1}' ] || [ "$line" == "[" ] ; then
    echo "$line" || exit 1
  else    
    STATUS=$(dbus-send --print-reply --dest="$SPOTIFY" "$MEDIAPLAYER" \
      "$GET_PROPERTIES" string:"$PLAYER" string:'PlaybackStatus' 2> /dev/null)
    if [ "$STATUS" == "" ] ; then
      echo "$line" || exit 1    
      continue
    fi
    STATUS=${STATUS#*\"}
    STATUS=${STATUS::-1}
    if [ "$STATUS" == "Playing" ] || [ "$STATUS" == "Paused" ] ; then
      if [ "$STATUS" == "Playing" ] ; then
        ICON=""
      else
        ICON="" 
      fi
      METADATA=$(sp-metadata)
      ARTIST=$(echo "$METADATA" | grep --color=never "artist")
      ARTIST=${ARTIST#*|}
      TITLE=$(echo "$METADATA" | grep --color=never "title")
      TITLE=${TITLE#*|}
      echo ",[{\"name\":\"spotify\",\"full_text\":\"$ICON $ARTIST - $TITLE\"},${line#*[}" || exit 1
    fi
  fi
done
