#!/bin/bash

SRC_DIR=$(cd $(dirname $0) && pwd)
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

THEME_NAME=Qogir
COLOR_VARIANTS=('' '-light' '-dark')
THEME_VARIANTS=('' '-manjaro' '-ubuntu')

[[ ! -d ${AURORAE_DIR} ]] && mkdir -p ${AURORAE_DIR}
[[ ! -d ${SCHEMES_DIR} ]] && mkdir -p ${SCHEMES_DIR}
[[ ! -d ${PLASMA_DIR} ]] && mkdir -p ${PLASMA_DIR}
[[ ! -d ${LOOKFEEL_DIR} ]] && mkdir -p ${LOOKFEEL_DIR}
[[ ! -d ${KVANTUM_DIR} ]] && mkdir -p ${KVANTUM_DIR}
[[ ! -d ${WALLPAPER_DIR} ]] && mkdir -p ${WALLPAPER_DIR}

install() {
  local name=${1}
  local color=${2}
  local theme=${3}

  if [[ ${theme} == '-manjaro' ]]; then
    local a_theme="manjaro"
  elif [[ ${theme} == '-ubuntu' ]]; then
    local a_theme="ubuntu"
  else
    local a_theme=""
  fi

  [[ ${color} == '-dark' ]] && local ELSE_DARK=${color} && local c_color=dark
  [[ ${color} == '-light' ]] && local ELSE_LIGHT=${color} && local c_color=light

  cp -r ${SRC_DIR}/aurorae/themes/*                                                  ${AURORAE_DIR}
  cp -r ${SRC_DIR}/color-schemes/*.colors                                            ${SCHEMES_DIR}
  cp -r ${SRC_DIR}/wallpaper/${name}${theme}${ELSE_DARK}                             ${WALLPAPER_DIR}
  cp -r ${SRC_DIR}/Kvantum/*                                                         ${KVANTUM_DIR}
  cp -r ${SRC_DIR}/plasma/desktoptheme/${name}${theme}${ELSE_DARK}                   ${PLASMA_DIR}
  cp -r ${SRC_DIR}/plasma/desktoptheme/icons${ELSE_DARK}                             ${PLASMA_DIR}/${name}${theme}${ELSE_DARK}/icons

  if [[ ${color} == '-dark' ]]; then
    cp -r ${SRC_DIR}/color-schemes/${name}${a_theme}dark.colors                      ${PLASMA_DIR}/${name}${theme}-dark/colors
  else
    cp -r ${SRC_DIR}/color-schemes/${name}${a_theme}light.colors                     ${PLASMA_DIR}/${name}${theme}/colors
  fi

  cp -r ${SRC_DIR}/plasma/look-and-feel/com.github.vinceliuice.${name}${theme}${color} ${LOOKFEEL_DIR}
}

echo "Installing 'Qogir kde themes'..."

for color in "${colors[@]:-${COLOR_VARIANTS[@]}}"; do
  for theme in "${themes[@]:-${THEME_VARIANTS[@]}}"; do
    install "${name:-${THEME_NAME}}" "${color}" "${theme}"
  done
done

echo "Install finished..."
