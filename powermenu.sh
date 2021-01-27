#!/bin/bash
shutdown="";        # "\uE9C0"
reboot="";          # "\uE9C4"
sleep="";           # "\uE9A3"
logout="";          # "\uE991"
lock="";            # "\uE98F"
options="$shutdown\n$reboot\n$sleep\n$logout\n$lock"

DEFAULT_WIDTH=1920
WIDTH=$(xdpyinfo | grep dimensions | awk '{print $2}' | cut -d 'x' -f 1 )
DEFAULT_FONTSIZE=60
FONTSIZE=$(echo "$WIDTH/$DEFAULT_WIDTH*$DEFAULT_FONTSIZE" | bc -l)

while getopts "lp" OPT; do
    case "$OPT" in
        p) PRESELECTION=0 ;;
        l) PRESELECTION=3 ;;
        *) PRESELECTION=4 ;;
    esac
done
if (( $OPTIND == 1 )); then
   PRESELECTION=4
fi

selected="$(echo -e "$options" | 
            rofi -show-icons -theme powermenu_theme.rasi \
                 -font "WeblySleek UI Light, $FONTSIZE" \
                 -p "See you later, ${LOGNAME^}!" -dmenu -selected-row ${PRESELECTION})"

case $selected in

    $shutdown)
        systemctl poweroff
        ;;

    $reboot)
        systemctl reboot
        ;;

    $sleep)
        systemctl suspend
        ;;

    $logout)
        bspc quit
        ;;

    $lock)
        xsecurelock
        ;;

esac
