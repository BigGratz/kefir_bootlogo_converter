#!/bin/bash

# Проверяем наличие установленного утилиты ImageMagick
if ! command -v convert &> /dev/null; then
    echo "Установите ImageMagick для работы с изображениями."
    exit 1
fi

# Перебираем все файлы из текущей папки
for file in *; do
    # Проверяем, что это файл изображения
    if [[ -f "$file" && $(file -b --mime-type "$file") =~ ^image/ ]]; then
        # Переворачиваем изображение на 270 градусов
        convert "$file" -rotate 270 temp.bmp

        # Преобразуем в заданный формат (720x1280, 32-битный цвет RGBA)
        convert temp.bmp -resize 720x1280 -depth 8 -type TrueColorAlpha bootlogo_kefir.bmp

        # Удаляем временный файл
        rm temp.bmp

        echo "Изображение $file успешно преобразовано в bootlogo_kefir.bmp"
    fi
done
