#!/usr/bin/env bash
printf "\e[0;32;1mThis script will install (or update) some lua stuff that is used by some of my scripts.\n\e[0;37;0m"
read -p "Press enter to continue."
yay -Sy --needed luarocks
sudo luarocks install luaposix
