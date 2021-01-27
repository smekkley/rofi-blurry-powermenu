#!/bin/bash

mkdir -p ~/bin
cp -r powermenu.sh ~/bin
cp -r powermenu_theme.rasi ~/.local/share/rofi/themes
cp -r fonts/* ~/.fonts/
fc-cache -vf
