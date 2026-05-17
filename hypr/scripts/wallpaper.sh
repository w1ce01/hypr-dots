#!/bin/bash
sleep 1
rm -rf ~/.cache/wallust/
WALLPAPER=$(grep "^wallpaper" ~/.config/waypaper/config.ini | head -1 | cut -d'=' -f2 | tr -d ' ' | sed "s|~|$HOME|g")

/home/w1ce/.cargo/bin/wallust run "$WALLPAPER"

CACHE=$(ls ~/.cache/wallust/*/FastResize_Salience_auto_SalienceDark 2>/dev/null | head -1)
BG=$(cat "$CACHE" | grep '"background"' | cut -d'"' -f4)
FG=$(cat "$CACHE" | grep '"foreground"' | cut -d'"' -f4)
C1=$(cat "$CACHE" | grep '"color1"' | cut -d'"' -f4)
C2=$(cat "$CACHE" | grep '"color2"' | cut -d'"' -f4)
C3=$(cat "$CACHE" | grep '"color3"' | cut -d'"' -f4)
C4=$(cat "$CACHE" | grep '"color4"' | cut -d'"' -f4)
C5=$(cat "$CACHE" | grep '"color5"' | cut -d'"' -f4)
C6=$(cat "$CACHE" | grep '"color6"' | cut -d'"' -f4)

cat > ~/.config/wallust/waybar-colors.css << EOF
window#waybar { background-color: $BG; color: $FG; }
#cpu { color: $C2; border-bottom: 3px solid $C2; }
#memory { color: $C4; border-bottom: 3px solid $C4; }
#network { color: $C6; border-bottom: 3px solid $C6; }
#pulseaudio { color: $C5; border-bottom: 3px solid $C5; }
#clock { color: $FG; border-bottom: 3px solid $C1; }
#custom-notification { color: $C3; border-bottom: 3px solid $C3; }
EOF

pkill waybar
sleep 0.5
waybar &
disown
