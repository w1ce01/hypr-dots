cat > hypr/scripts/wallpaper.sh << 'EOF'
#!/usr/bin/env bash
set -euo pipefail

# ─────────────────────────────────────────────────
# 🖼️ Dynamic Wallpaper & Theme Changer
# ─────────────────────────────────────────────────

# Проверка зависимостей
for cmd in wallust swww hyprctl; do
    command -v "$cmd" >/dev/null || { echo "❌ $cmd required" >&2; exit 1; }
done

WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/Pictures/wallpapers}"
WALLPAPER="${1:-}"

# Выбор обоев
if [[ -z "$WALLPAPER" ]]; then
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.webp" \) | shuf -n1)
fi

[[ ! -f "$WALLPAPER" ]] && { echo "❌ Wallpaper not found: $WALLPAPER" >&2; exit 1; }

echo "🎨 Applying: $(basename "$WALLPAPER")"

# Применяем обои
swww img "$WALLPAPER" --transition-type=any --transition-fps=60 --transition-duration=1

# Генерируем цвета
wallust run -s "$WALLPAPER"

# Перезапускаем приложения с новыми цветами
# Waybar
if pgrep -x waybar >/dev/null; then
    pkill -USR2 waybar
    sleep 0.2
fi

# Fuzzel (перезапуск не нужен, подхватит при следующем запуске)

# Уведомление
if command -v notify-send >/dev/null; then
    notify-send -t 2000 -i "$WALLPAPER" "🎨 Theme Updated" "$(basename "$WALLPAPER")" || true
fi

# Сохраняем путь для hyprlock
mkdir -p ~/.cache
cp "$WALLPAPER" ~/.cache/wallpaper

echo "✅ Done"
EOF

chmod +x hypr/scripts/wallpaper.sh
