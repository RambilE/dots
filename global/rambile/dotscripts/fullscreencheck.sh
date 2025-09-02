#! /bin/bash
a=$(hyprctl activeworkspace | grep -o "hasfullscreen: 1"); if [ "$a" == "hasfullscreen: 1" ]; then printf " "; else printf " "; fi
