#!/bin/sh
pacmd set-card-profile `pacmd list-cards | grep bluez_card -B1 | grep index | awk '{print $2}'` off
# sleep 2
echo "disconnect $BLUETOOTH_MAC\n quit"|bluetoothctl
sleep 5
echo "connect $BLUETOOTH_MAC\n quit"|bluetoothctl
sleep 5
pacmd set-card-profile `pacmd list-cards | grep bluez_card -B1 | grep index | awk '{print $2}'` a2dp_sink
