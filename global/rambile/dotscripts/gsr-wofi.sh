#!/usr/bin/env bash
if [[ $(pidof gpu-screen-recorder-gtk) == "" ]]; then
        nohup gpu-screen-recorder-gtk &
        exit
fi

choice=$(printf "Save replay\nStop recording/replay\nToggle record sleep" | wofi --dmenu --prompt="GSR controls" -k /dev/null)

#if [ "$choice" == "Open GSR UI" ]; then
#        nohup gpu-screen-recorder-gtk &

if [ "$choice" == "Toggle record sleep" ]; then
    killall -SIGUSR2 gpu-screen-recorder; notify-send -t 2000 "GSR sleep is toggled!" "Gui is lying."

elif [ "$choice" == "Stop recording/replay" ]; then
    killall -SIGINT gpu-screen-recorder

elif [ "$choice" == "Save replay" ]; then
    replayDir=$(cat ~/.config/gpu-screen-recorder/config | grep -oP "(replay.save_directory)\K.*")
    killall -SIGUSR1 gpu-screen-recorder; notify-send -t 2000 "Saved replay!" "Saved in $replayDir"

fi

