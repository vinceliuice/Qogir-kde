#!/bin/bash

ROOT_UID=0

# Destination directory
if [ "$UID" -eq "$ROOT_UID" ]; then
  AURORAE_DIR="/usr/share/aurorae/themes"
  SCHEMES_DIR="/usr/share/color-schemes"
  PLASMA_DIR="/usr/share/plasma/desktoptheme"
  LOOKFEEL_DIR="/usr/share/plasma/look-and-feel"
  KVANTUM_DIR="/usr/share/Kvantum"
  WALLPAPER_DIR="/usr/share/wallpapers"
else
  AURORAE_DIR="$HOME/.local/share/aurorae/themes"
  SCHEMES_DIR="$HOME/.local/share/color-schemes"
  PLASMA_DIR="$HOME/.local/share/plasma/desktoptheme"
  LOOKFEEL_DIR="$HOME/.local/share/plasma/look-and-feel"
  KVANTUM_DIR="$HOME/.config/Kvantum"
  WALLPAPER_DIR="$HOME/.local/share/wallpapers"
fi

rm -rfv ${AURORAE_DIR}/Qogir*
rm -rfv ${SCHEMES_DIR}/Qogir*
rm -rfv ${WALLPAPER_DIR}/Qogir
rm -rfv ${KVANTUM_DIR}/Qogir*
rm -rfv ${PLASMA_DIR}/Qogir*
rm -rfv ${LOOKFEEL_DIR}/com.github.vinceliuice.Qogir*

echo "Uninstalling 'Qogir kde themes'..."

echo "Uninstall finished..."
