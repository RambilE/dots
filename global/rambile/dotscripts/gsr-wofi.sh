#!/usr/bin/env bash
if [[ $(pidof gpu-screen-recorder-gtk) == "" ]]; then
        nohup gpu-screen-recorder-gtk &
        exit
fi

choice=$(printf "Toggle sleep state\nStop recording/replay\nSave replay" | wofi --dmenu --prompt="GSR controls")

#if [ "$choice" == "Open GSR UI" ]; then
#        nohup gpu-screen-recorder-gtk &

if [ "$choice" == "Toggle sleep state" ]; then
        killall -SIGUSR2 gpu-screen-recorder; notify-send "GSR sleep is toggled!" "Idk the state though (and it'll lie in the gui"

elif [ "$choice" == "Stop recording/replay" ]; then
        killall -SIGINT gpu-screen-recorder

elif [ "$choice" == "Save replay" ]; then
        killall -SIGUSR1 gpu-screen-recorder; notify-send "Saved replay!" "Should be in ~/Videos"

fi

