#!/bin/sh

# Папка, где ты будешь хранить свои обои (создадим её)
WALL_DIR="$HOME/Pictures/Wallpapers"
mkdir -p "$WALL_DIR"

# Проверяем, есть ли там вообще картинки. Если пусто — создаем заглушку
if [ -z "$(ls -A "$WALL_DIR")" ]; then
    notify-send "Смена обоев" "Папка $WALL_DIR пуста! Закинь туда .jpg или .png картинки."
    exit 1
fi

# Сканируем папку и скармливаем список файлов в Rofi menu
SELECTION=$(ls -1 "$WALL_DIR" | rofi -dmenu -p "   Выбери обои" -theme-str 'window {width: 35%;}')

# Если пользователь выбрал файл — принудительно устанавливаем его через feh
if [ -n "$SELECTION" ]; then
    feh --bg-fill "$WALL_DIR/$SELECTION"
    
    # Сохраняем путь к выбранным обоям в скрытый файл, чтобы bspwmrc восстанавливал их при загрузке
    echo "$WALL_DIR/$SELECTION" > "$HOME/.current_wallpaper"
    notify-send "Смена обоев" "Установлены обои: $SELECTION"
fi
