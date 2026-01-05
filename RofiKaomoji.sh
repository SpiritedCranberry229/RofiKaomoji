### AUTHOR: SpiritedCranberry229
### Reddit: SpiritedCranberry229
### Email: spiritedcranberry229@duck.com

#!/bin/bash

KAOMOJI_FILE="$HOME/.config/rofi/kaomoji.txt"

CATEGORY=$(awk -F']' '{cat=$1; gsub(/^\[/,"",cat); if(cat!="") print cat}' "$KAOMOJI_FILE" \
           | sort -u | rofi -dmenu -p "Category:")

[ -z "$CATEGORY" ] && exit

CHOICE=$(awk -v cat="$CATEGORY" -F']' '$1=="["cat {gsub(/^[ \t]+/,"",$2); if($2!="") print $2}' "$KAOMOJI_FILE" \
         | rofi -dmenu -p "$CATEGORY kaomoji:")

if [ -n "$CHOICE" ]; then
    if command -v wl-copy >/dev/null 2>&1; then
        echo -n "$CHOICE" | wl-copy
    else
        echo -n "$CHOICE" | xclip -selection clipboard
    fi
    notify-send "Kaomoji Copied!" "$CHOICE"
fi
