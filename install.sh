#!/bin/bash

SRC_DIR=$(cd $(dirname $0) && pwd)

AURORAE_DIR="$HOME/.local/share/aurorae/themes"
SCHEMES_DIR="$HOME/.local/share/color-schemes"
PLASMA_DIR="$HOME/.local/share/plasma/desktoptheme"
LOOKFEEL_DIR="$HOME/.local/share/plasma/look-and-feel"
WALLPAPER_DIR="$HOME/.local/share/wallpapers"
KVANTUM_DIR="$HOME/.config/Kvantum"

THEME_NAME=Qogir
COLOR_VARIANTS=('' '-light' '-dark')

install() {
  local name=${1}
  local color=${2}

  [[ ${color} == '-dark' ]] && local ELSE_DARK=${color} && local c_color=dark
  [[ ${color} == '-light' ]] && local ELSE_LIGHT=${color} && local c_color=light

  local AURORAE_THEME=${AURPRAE_DIR}/${name}${color}
  local PLASMA_THEME=${PLASMA_DIR}/${name}${color}
  local LOOKFEEL_THEME=${LOOKFEEL_DIR}/com.github.vinceliuice.${name}${color}
  local SCHEMES_THEME=${SCHEMES_DIR}/${name}${c_color}.colors
  local WALLPAPER_THEME=${WALLPAPER_DIR}/${name}/${name}${color}.jpeg
  local KVANTUM_THEME=${KVANTUM_DIR}/${name}${color}

  mkdir -p                                                                           ${AURORAE_DIR}
  mkdir -p                                                                           ${SCHEMES_DIR}
  mkdir -p                                                                           ${PLASMA_DIR}
  mkdir -p                                                                           ${LOOKFEEL_DIR}
  mkdir -p                                                                           ${KVANTUM_DIR}
  mkdir -p                                                                           ${WALLPAPER_DIR}/${name}

  [[ -d ${AURORAE_THEME} ]] && rm -rf ${AURORAE_THEME}
  [[ -d ${PLASMA_THEME} ]] && rm -rf ${PLASMA_THEME}
  [[ -d ${LOOKFEEL_THEME} ]] && rm -rf ${LOOKFEEL_THEME}
  [[ -d ${SCHEMES_THEME} ]] && rm -rf ${SCHEMES_THEME}
  [[ -d ${WALLPAPER_THEME} ]] && rm -rf ${WALLPAPER_THEME}
  [[ -d ${KVANTUM_THEME} ]] && rm -rf ${KVANTUM_THEME}

  cp -ur ${SRC_DIR}/aurorae/themes/${name}${color}                                   ${AURORAE_DIR}
  cp -ur ${SRC_DIR}/color-schemes/*.colors                                           ${SCHEMES_DIR}
  cp -ur ${SRC_DIR}/wallpaper/*.jpeg                                                 ${WALLPAPER_DIR}/${name}
  cp -ur ${SRC_DIR}/Kvantum/${name}${color}                                          ${KVANTUM_DIR}
  cp -ur ${SRC_DIR}/plasma/desktoptheme/${name}${ELSE_DARK}                          ${PLASMA_DIR}
  cp -ur ${SRC_DIR}/color-schemes/${name}light.colors                                ${PLASMA_DIR}/${name}/colors
  cp -ur ${SRC_DIR}/color-schemes/${name}dark.colors                                 ${PLASMA_DIR}/${name}-dark/colors
  cp -ur ${SRC_DIR}/plasma/look-and-feel/com.github.vinceliuice.${name}${color}      ${LOOKFEEL_DIR}
}

echo "Installing 'Qogir kde themes'..."

for color in "${colors[@]:-${COLOR_VARIANTS[@]}}"; do
  install "${name:-${THEME_NAME}}" "${color}"
done

echo "Install finished..."
