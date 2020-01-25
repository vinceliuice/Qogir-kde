#!/bin/bash
if (( $EUID != 0 )); then
  echo "Please run as root"
  exit
else
  clear
  echo "Installing theme..."
  cp -r Qogir /usr/share/sddm/themes
  clear
  echo "Install finished..."
fi
