

################
## Variables
#################
#
## Keyboard input name
keyboard_input_name="1:1:AT_Translated_Set_2_keyboard"
#
## Date and time
date_and_week=$(date "+(week %-V) %Y.%m.%d")
current_time=$(date "+%H:%M:%S")



#commands
#############
#
## Battery or charger
battery_charge=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "percentage" | awk '{print $2}')
battery_status=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "state" | awk '{print $2}')
#
## Audio and multimedia
audio_volume=$(amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }')

loadavg_5min=$(cat /proc/loadavg | awk -F ' ' '{print $2}')

# Network
network=$(ip route get 1.1.1.1 | grep -Po '(?<=dev\s)\w+' | cut -f1 -d ' ')
# interface_easyname grabs the "old" interface name before systemd renamed it
interface_easyname=$(dmesg | grep $network | grep renamed | awk 'NF>1{print $NF}')
ping=$(ping -c 1 www.google.es | tail -1| awk '{print $4}' | cut -d '/' -f 2 | cut -d '.' -f 1)

audio_active='🔊'



if [ $battery_status = "discharging" ];
then
    battery_pluggedin='🔋'
else
    battery_pluggedin='⚡'
fi

if ! [ $network ]
then
   network_active="⛔"
else
   network_active="⇆"
fi

echo "$network_active $interface_easyname ($ping ms) | 🏋 $loadavg_5min% | $audio_active $audio_volume | $battery_pluggedin $battery_charge | $date_and_week  $current_time"
