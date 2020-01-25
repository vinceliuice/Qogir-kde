#!/bin/bash
if [[ "$EUID" != 0 ]]; then
  echo "Please run as root"
  exit
else
  echo "Installing theme..."
  cp -r Qogir /usr/share/sddm/themes
  echo "Install finished..."
fi
