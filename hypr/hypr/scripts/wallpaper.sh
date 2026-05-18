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
C7=$(cat "$CACHE" | grep '"color7"' | cut -d'"' -f4)
C8=$(cat "$CACHE" | grep '"color8"' | cut -d'"' -f4)
C9=$(cat "$CACHE" | grep '"color9"' | cut -d'"' -f4)
C10=$(cat "$CACHE" | grep '"color10"' | cut -d'"' -f4)
C11=$(cat "$CACHE" | grep '"color11"' | cut -d'"' -f4)
C12=$(cat "$CACHE" | grep '"color12"' | cut -d'"' -f4)
C13=$(cat "$CACHE" | grep '"color13"' | cut -d'"' -f4)
C14=$(cat "$CACHE" | grep '"color14"' | cut -d'"' -f4)
C15=$(cat "$CACHE" | grep '"color15"' | cut -d'"' -f4)

BORDER=$C1
hyprctl keyword general:col.active_border "rgb(${BORDER//\#/})"

cat > ~/.config/fuzzel/fuzzel.ini << EOF
[main]
font=JetBrains Mono Nerd Font:size=12
prompt="> "
lines=15
width=50
horizontal-pad=20
vertical-pad=10
inner-pad=10
[colors]
background=${BG//\#/}ff
text=${FG//\#/}ff
match=${C1//\#/}ff
selection=${C2//\#/}ff
selection-match=${C3//\#/}ff
selection-text=${FG//\#/}ff
border=${C4//\#/}ff
[border]
width=2
radius=0
[dmenu]
mode=text
EOF

cat > ~/.config/alacritty/colors.toml << EOF
[colors.primary]
background = "$BG"
foreground = "$FG"

[colors.normal]
black   = "$BG"
red     = "$C1"
green   = "$C2"
yellow  = "$C3"
blue    = "$C4"
magenta = "$C5"
cyan    = "$C6"
white   = "$FG"

[colors.bright]
black   = "$C1"
red     = "$C1"
green   = "$C2"
yellow  = "$C3"
blue    = "$C4"
magenta = "$C5"
cyan    = "$C6"
white   = "$FG"
EOF

# Обновляем цвет фона swaync
sed -i "s/background-color: #[0-9a-fA-F]\{6\}/background-color: $BG/g" ~/.config/swaync/style.css
pkill swaync
swaync &
disown

cat > ~/.config/wallust/waybar-colors.css << EOF
window#waybar { background-color: $BG; color: $FG; }
#cpu { color: $C2; border-bottom: 3px solid $C2; }
#language { color: $C3; border-bottom: 3px solid $C3; }
#memory { color: $C4; border-bottom: 3px solid $C4; }
#network { color: $C6; border-bottom: 3px solid $C6; }
#pulseaudio { color: $C5; border-bottom: 3px solid $C5; }
#clock { color: $FG; border-bottom: 3px solid $C1; }
#custom-notification { color: $C3; border-bottom: 3px solid $C3; }
EOF

touch ~/.config/alacritty/colors.toml
pkill waybar
sleep 0.5
waybar &
disown
