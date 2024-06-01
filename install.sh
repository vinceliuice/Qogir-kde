#!/usr/bin/env bash

SRC_DIR=$(cd $(dirname $0) && pwd)
ROOT_UID=0

# Destination directory
if [ "$UID" -eq "$ROOT_UID" ]; then
  echo
  echo " Do not run this with sudo ! "
  echo
  exit 0
else
  AURORAE_DIR="$HOME/.local/share/aurorae/themes"
  SCHEMES_DIR="$HOME/.local/share/color-schemes"
  PLASMA_DIR="$HOME/.local/share/plasma/desktoptheme"
  LOOKFEEL_DIR="$HOME/.local/share/plasma/look-and-feel"
  KVANTUM_DIR="$HOME/.config/Kvantum"
  WALLPAPER_DIR="$HOME/.local/share/wallpapers"
  PLASMOIDS_DIR="$HOME/.local/share/plasma/plasmoids"
  LAYOUT_DIR="$HOME/.local/share/plasma/layout-templates"
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
[[ ! -d ${PLASMOIDS_DIR} ]] && mkdir -p ${PLASMOIDS_DIR}
[[ ! -d ${LAYOUT_DIR} ]] && mkdir -p ${LAYOUT_DIR}

[[ -d ${AURORAE_DIR}/${THEME_NAME} ]] && rm -rf ${AURORAE_DIR}/${THEME_NAME}*
[[ -d ${PLASMA_DIR}/${THEME_NAME} ]] && rm -rf ${PLASMA_DIR}/${THEME_NAME}*
[[ -f ${SCHEMES_DIR}/${THEME_NAME}.colors ]] && rm -rf ${SCHEMES_DIR}/${THEME_NAME}*.colors
[[ -d ${LOOKFEEL_DIR}/com.github.vinceliuice.${THEME_NAME} ]] && rm -rf ${LOOKFEEL_DIR}/com.github.vinceliuice.${THEME_NAME}*
[[ -d ${KVANTUM_DIR}/${THEME_NAME} ]] && rm -rf ${KVANTUM_DIR}/${THEME_NAME}*
[[ -d ${WALLPAPER_DIR}/${THEME_NAME} ]] && rm -rf ${WALLPAPER_DIR}/${THEME_NAME}

install() {
  local name=${1}
  local color=${2}
  local theme=${3}

  if [[ ${theme} == '-manjaro' ]]; then
    local a_theme="Manjaro"
  elif [[ ${theme} == '-ubuntu' ]]; then
    local a_theme="Ubuntu"
  else
    local a_theme=""
  fi

  [[ ${color} == '-dark' ]] && local ELSE_DARK=${color}
  [[ ${color} == '-light' ]] && local ELSE_LIGHT=${color}

  cp -r ${SRC_DIR}/aurorae/themes/*                                                  ${AURORAE_DIR}
  cp -r ${SRC_DIR}/color-schemes/*.colors                                            ${SCHEMES_DIR}
  cp -r ${SRC_DIR}/wallpaper/${name}${theme}${ELSE_DARK}                             ${WALLPAPER_DIR}

  mkdir -p                                                                           ${KVANTUM_DIR}/${name}${theme}${color}
  cp -r ${SRC_DIR}/Kvantum/Qogir${color}/Qogir${color}.svg                           ${KVANTUM_DIR}/${name}${theme}${color}/${name}${theme}${color}.svg
  cp -r ${SRC_DIR}/Kvantum/Qogir${color}/Qogir${color}.kvconfig                      ${KVANTUM_DIR}/${name}${theme}${color}/${name}${theme}${color}.kvconfig
  mkdir -p                                                                           ${KVANTUM_DIR}/${name}${theme}${color}-solid
  cp -r ${KVANTUM_DIR}/${name}${theme}${color}/${name}${theme}${color}.svg           ${KVANTUM_DIR}/${name}${theme}${color}-solid/${name}${theme}${color}-solid.svg
  cp -r ${SRC_DIR}/Kvantum/${name}${color}-solid/${name}${color}-solid.kvconfig      ${KVANTUM_DIR}/${name}${theme}${color}-solid/${name}${theme}${color}-solid.kvconfig

  if [[ ${theme} == '-manjaro' ]]; then
    sed -i "s|#5294e2|#2eb398|"                                                      ${KVANTUM_DIR}/${name}${theme}${color}/${name}${theme}${color}.svg
    sed -i "s|#5294e2|#2eb398|"                                                      ${KVANTUM_DIR}/${name}${theme}${color}/${name}${theme}${color}.kvconfig
    sed -i "s|#5294e2|#2eb398|"                                                      ${KVANTUM_DIR}/${name}${theme}${color}-solid/${name}${theme}${color}-solid.svg
    sed -i "s|#5294e2|#2eb398|"                                                      ${KVANTUM_DIR}/${name}${theme}${color}-solid/${name}${theme}${color}-solid.kvconfig
  fi

  if [[ ${theme} == '-ubuntu' ]]; then
    sed -i "s|#5294e2|#fb8441|"                                                      ${KVANTUM_DIR}/${name}${theme}${color}/${name}${theme}${color}.svg
    sed -i "s|#5294e2|#fb8441|"                                                      ${KVANTUM_DIR}/${name}${theme}${color}/${name}${theme}${color}.kvconfig
    sed -i "s|#5294e2|#fb8441|"                                                      ${KVANTUM_DIR}/${name}${theme}${color}-solid/${name}${theme}${color}-solid.svg
    sed -i "s|#5294e2|#fb8441|"                                                      ${KVANTUM_DIR}/${name}${theme}${color}-solid/${name}${theme}${color}-solid.kvconfig
  fi

  mkdir -p                                                                           ${PLASMA_DIR}/${name}${theme}${ELSE_DARK}
  cp -r ${SRC_DIR}/plasma/desktoptheme/Qogir/*                                       ${PLASMA_DIR}/${name}${theme}${ELSE_DARK}
  sed -i "s|Name=Qogir|Name=${name}${theme}${ELSE_DARK}|"                            ${PLASMA_DIR}/${name}${theme}${ELSE_DARK}/metadata.desktop
  sed -i "s/Qogir/${name}${theme}${ELSE_DARK}/g"                            ${PLASMA_DIR}/${name}${theme}${ELSE_DARK}/metadata.json
  sed -i "s|defaultWallpaperTheme=Qogir|defaultWallpaperTheme=${name}${theme}${ELSE_DARK}|" ${PLASMA_DIR}/${name}${theme}${ELSE_DARK}/metadata.desktop

  if [[ ${color} == '-dark' ]]; then
    cp -r ${SRC_DIR}/color-schemes/${name}${a_theme}Dark.colors                      ${PLASMA_DIR}/${name}${theme}-dark/colors
    cp -r ${SRC_DIR}/plasma/desktoptheme/Qogir-dark/*                                ${PLASMA_DIR}/${name}${theme}-dark
  else
    cp -r ${SRC_DIR}/color-schemes/${name}${a_theme}Light.colors                     ${PLASMA_DIR}/${name}${theme}/colors
  fi

  cp -r ${SRC_DIR}/plasma/look-and-feel/com.github.vinceliuice.${name}${theme}${color} ${LOOKFEEL_DIR}
  cp -ur ${SRC_DIR}/plasma/plasmoids/*                                               ${PLASMOIDS_DIR}
  cp -ur ${SRC_DIR}/plasma/layout-templates/*                                        ${LAYOUT_DIR}
}

echo "Installing 'Qogir kde themes'..."

for color in "${colors[@]:-${COLOR_VARIANTS[@]}}"; do
  for theme in "${themes[@]:-${THEME_VARIANTS[@]}}"; do
    install "${name:-${THEME_NAME}}" "${color}" "${theme}"
  done
done

echo "Install finished..."
