#!/usr/bin/env bash
# This is rambile .files installer config file
# It is used to:
#   1. Define dependencies
#   2. Define ignored packages in dependencies
#   3. Define paths for installation
# Todo:
#   1. Config for different setups (screen sizes, presets etc.)
#   2. Choose aur helper (paru/yay/etc)
#   3. idk

# aurh = yay
dotdir="./testo"

dependencies () {
    deplist=("hyprland" "hyprpaper" "hyprpolkitagent" "hyprsunset"  # hypr stuff
             "mako" "syshud" "waybar" "network-manager-applet" "wlogout"  # what you see most of the time
             "wofi" "wofimoji" "wofi-calc" "cliphist"  # wofi stuff
             "foot" "flameshot" "nwg-look" "qt6ct" "qt5ct" "thunar" "gvfs" "wiremix" "gpu-screen-recorder-gtk" "neovim" "swayimg" # functional software
             "breeze" "breeze5" "catppuccin-gtk-theme-mocha" "catppuccin-qt5ct-git" "papirus-icon-theme-git" "rose-pine-hyprcursor" "ttf-0xproto-nerd") # theming stuff
}

ignorepkgs () {
    # example: ignorelist=(hyprland waybar syshud)
    ignorelist=()
}

paths () {
    # broken; to fix later
    # declare -A dots
    # dots[hypr]=( "$XDG_CONFIG_HOME/testodots" "$dotdir/testodots/*" )
    echo meow
}
