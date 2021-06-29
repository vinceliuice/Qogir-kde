#!/usr/bin/env bash

ROOT_UID=0

# Destination directory
AURORAE_DIR="$HOME/.local/share/aurorae/themes"
SCHEMES_DIR="$HOME/.local/share/color-schemes"
PLASMA_DIR="$HOME/.local/share/plasma/desktoptheme"
LOOKFEEL_DIR="$HOME/.local/share/plasma/look-and-feel"
KVANTUM_DIR="$HOME/.config/Kvantum"
WALLPAPER_DIR="$HOME/.local/share/wallpapers"

rm -rfv ${AURORAE_DIR}/Qogir*
rm -rfv ${SCHEMES_DIR}/Qogir*
rm -rfv ${WALLPAPER_DIR}/Qogir
rm -rfv ${KVANTUM_DIR}/Qogir*
rm -rfv ${PLASMA_DIR}/Qogir*
rm -rfv ${LOOKFEEL_DIR}/com.github.vinceliuice.Qogir*

echo "Uninstalling 'Qogir kde themes'..."

echo "Uninstall finished..."
