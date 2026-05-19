cat > CHANGELOG.md << 'EOF'
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0-fix] - 2026-05-19
### 🚨 Fixed
- Удалены дублирующиеся вложенные директории (`wallust/wallust`, `waybar/waybar`)
- Заменены битые симлинки с абсолютными путями (`/home/w1ce/...`) на портативные конфиги
- Убраны хардкод-пути в `wallpaper.sh` и других скриптах
- Исправлен синтаксис `waybar/config.jsonc` (висячие запятые, `height`, раскрытие `~`)
- Убран `layout = scrolling` (требует внешний плагин, не входит в основной Hyprland)
- Заменены захардкоженные мониторы (`DP-2`, `HDMI-A-1`) на авто-определение
- Все `exec-once` обёрнуты в проверки `command -v` для предотвращения крашей при старте
- Отключены `wayvnc` и `deskflow` по умолчанию (безопасность + зависимость от конфига)
- Удалена сломанная `monitor` субмапа с жёсткими портами
- Во все скрипты добавлен `set -euo pipefail` и валидация зависимостей
- Добавлены переменные окружения Wayland (`GDK_BACKEND`, `QT_QPA_PLATFORM` и др.)
- Добавлены базовые `hypridle.conf` и `hyprlock.conf`

### ✨ Added
- `.gitignore` для dotfiles, редакторов, кэшей и генерируемых файлов
- Интеграция динамических цветов `wallust` → `hyprland` через генерацию `colors-hyprland.conf`
- Безопасный `wallpaper.sh` с фоллбэками, уведомлениями и `hyprctl reload`

### 🔒 Security
- Убран незащищённый `wayvnc` из автозапуска
- Запрещён запуск `deskflow` без валидного конфига
- Добавлена проверка зависимостей перед выполнением критических команд

### 📦 Infrastructure
- Очищены `.swp`, `.save` и временные файлы из репозитория
- Стандартизированы права на скрипты (`chmod +x`)
- Подготовлена структура под CI/CD валидацию
EOF
