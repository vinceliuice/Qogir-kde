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

  mkdir -p                                                                           ${AURORAE_DIR}
  mkdir -p                                                                           ${SCHEMES_DIR}
  mkdir -p                                                                           ${PLASMA_DIR}
  mkdir -p                                                                           ${LOOKFEEL_DIR}
  mkdir -p                                                                           ${KVANTUM_DIR}
  mkdir -p                                                                           ${WALLPAPER_DIR}/${name}

  cp -r ${SRC_DIR}/aurorae/themes/*                                                  ${AURORAE_DIR}
  cp -r ${SRC_DIR}/color-schemes/*.colors                                            ${SCHEMES_DIR}
  cp -r ${SRC_DIR}/wallpaper/*.jpeg                                                  ${WALLPAPER_DIR}/${name}
  cp -r ${SRC_DIR}/Kvantum/*                                                         ${KVANTUM_DIR}
  cp -r ${SRC_DIR}/plasma/desktoptheme/${name}${ELSE_DARK}                           ${PLASMA_DIR}
  cp -r ${SRC_DIR}/plasma/desktoptheme/icons${ELSE_DARK}                             ${PLASMA_DIR}/${name}${ELSE_DARK}/icons

  if [[ ${color} == '-dark' ]]; then
    cp -r ${SRC_DIR}/color-schemes/${name}dark.colors                                ${PLASMA_DIR}/${name}-dark/colors
  else
    cp -r ${SRC_DIR}/color-schemes/${name}light.colors                               ${PLASMA_DIR}/${name}/colors
  fi

  cp -r ${SRC_DIR}/plasma/look-and-feel/com.github.vinceliuice.${name}${color}      ${LOOKFEEL_DIR}
}

echo "Installing 'Qogir kde themes'..."

for color in "${colors[@]:-${COLOR_VARIANTS[@]}}"; do
  install "${name:-${THEME_NAME}}" "${color}"
done

echo "Install finished..."
