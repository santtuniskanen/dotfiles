#!/usr/bin/env bash
# Red Fox Rofi Power Menu
# Save as ~/.config/rofi/powermenu.sh and make executable: chmod +x ~/.config/rofi/powermenu.sh

theme="$HOME/.config/rofi/redfox.rasi"

# Options
shutdown="⏻ Shutdown"
reboot=" Reboot"
lock=" Lock"
suspend="⏾ Suspend"
logout="󰍃 Logout"

# Rofi command
rofi_cmd() {
    rofi -dmenu \
        -p "Power Menu" \
        -mesg "Uptime: $(uptime -p | sed -e 's/up //g')" \
        -theme "$theme" \
        -theme-str 'window {width: 400px;}' \
        -theme-str 'listview {lines: 5;}'
}

# Pass variables to rofi
run_rofi() {
    echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Confirmation dialog
confirm_exit() {
    rofi -dmenu \
        -p 'Confirmation' \
        -mesg "Are you sure you want to $1?" \
        -theme "$theme" \
        -theme-str 'window {width: 400px;}' \
        -theme-str 'listview {lines: 2;}' <<< $'Yes\nNo'
}

# Execute command
run_cmd() {
    selected="$(confirm_exit "$1")"
    if [[ "$selected" == "Yes" ]]; then
        if [[ $1 == 'shutdown' ]]; then
            systemctl poweroff
        elif [[ $1 == 'reboot' ]]; then
            systemctl reboot
        elif [[ $1 == 'suspend' ]]; then
            systemctl suspend
        elif [[ $1 == 'logout' ]]; then
            swaymsg exit
        fi
    else
        exit 0
    fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
        run_cmd shutdown
        ;;
    $reboot)
        run_cmd reboot
        ;;
    $lock)
        swaylock
        ;;
    $suspend)
        run_cmd suspend
        ;;
    $logout)
        run_cmd logout
        ;;
esac
