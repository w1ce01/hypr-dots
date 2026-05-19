cat > hypr/scripts/wallpaper.sh << 'EOF'
#!/usr/bin/env bash
set -euo pipefail

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 🖼️ Wallpaper setter with dynamic colors (wallust + swww)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Проверка зависимостей
for cmd in wallust swww hyprctl grep sed; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "❌ ERROR: Required command '$cmd' not found in PATH" >&2
        exit 1
    fi
done

# Переменные
WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/Pictures/wallpapers}"
WALLPAPER="${1:-}"

# Если не передан файл — выбираем случайный
if [[ -z "$WALLPAPER" ]]; then
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.webp" \) | shuf -n1)
fi

# Валидация
if [[ ! -f "$WALLPAPER" ]]; then
    echo "❌ ERROR: Wallpaper not found: $WALLPAPER" >&2
    exit 1
fi

echo "🎨 Applying: $WALLPAPER"

# Применяем обои через swww
swww img "$WALLPAPER" --transition-type=any --transition-fps=60 --transition-duration=1

# Генерируем цвета через wallust (используем PATH, не хардкод!)
WALLUST_BIN="${WALLUST_BIN:-$(command -v wallust)}"
"$WALLUST_BIN" run -s "$WALLPAPER"

# Применяем цвета в приложениях
# (предполагаем, что wallust создал файлы в ~/.config/wallust/)

# Перезагружаем waybar, если запущен
if pgrep -x waybar >/dev/null; then
    pkill -USR2 waybar  # мягкая перезагрузка
    sleep 0.2
fi

# Перезагружаем hyprland конфиг для обновления цветов границ
hyprctl reload || true

# Уведомление (безопасное)
if command -v notify-send >/dev/null 2>&1; then
    notify-send -t 2000 -i "$WALLPAPER" "🖼️ Wallpaper changed" "$(basename "$WALLPAPER")" || true
fi

echo "✅ Done"
EOF

chmod +x hypr/scripts/wallpaper.sh
git add hypr/scripts/wallpaper.sh
git commit -m "fix: remove absolute paths, add error handling in wallpaper.sh"
