#!/bin/bash
# 1. check deps
# 2. install
# 3. remove
#
clear
printf "\e[0;32;1mRambilE .files installation helper script (github.com/RambilE/dots)\n\e[0;37;0m"

function main {
printf "1. Check deps\n2. Install dots\n3. Remove dots\n"
read -p "Your choice: " choice

# deps
if [[ $choice == "1" || $choice == "deps" || $choice == "check deps" ]] then
    printf "Checking dependencies...\n\n"
    
    deplist=("hyprland" "hyprpaper" "hyprpolkitagent" "mako" "waybar" "wofi" "wlogout" "hyprshot" "satty" "qt6ct" "qt5ct" "vlc" "thunar" "gvfs" "pavucontrol" "gpu-screen-recorder-gtk" "ttf-0xproto-nerd")
    
    err=()
    for dep in "${deplist[@]}";
    do
        if ! [[ $(pacman -Qq $dep 2> /dev/null) == "$dep" ]] then
            printf "\e[0;31;1m$dep was not found!\e[0;37;0m\n"
            err+=($dep)
        fi
    done

    if ! [[ $err == "" ]] then
        read -p "Dependencies are missing! install them now? (y/n) " choice
        if [[ $choice == "y" || $choice == "yes" || $choice = "ya" ]] then
            yay -Sy $err
            printf "\n\n"
            main
        elif [[ $choice == "n" || $choice == "no" || $choice == "nah" ]] then
            printf "\n\n"
            main
        else
            exit 0
        fi
    else
        printf "\e[3mAll dependencies are installed!\e[0m\n\n"
        main
    fi

elif [[ $choice == "2" || $choice == "install" ]] then
        printf "\e[0;31;1mBecause i'm lazy to do it the other way, you need to clone this repo in ~/code/ in order for some bash scripts and wallpapers to work.\nIf you want them to work from other directories, you'll need to edit ~/.config/hypr/hyprpaper.conf and ~/.config/hypr/binds_util.conf (line 21) and copy these files where you want them to be.\n\e[0;37;0m"
        read -p "Please press anything to continue to installation. This will link files from ./global/ to where they need to be. This will also copy all relevant dotfiles to ./backup/ dir. Please be sure that you're installing this from the same block device that your ~/.config/ directory is as it is hard links. "
        
        printf "\e[3mBacking up files...\e[3m\n"
        mkdir backup 2> /dev/null
        cp -r ~/.config/hypr ./backup
        cp -r ~/.config/wlogout ./backup
        cp -r ~/.config/wofi ./backup
        cp -r ~/.config/waybar ./backup
        cp -r ~/.config/fastfetch ./backup
        cp -r ~/.config/qt6ct ./backup
        cp -r ~/.config/mako ./backup
        cp -r ~/.config/gtk-3.0 ./backup
        cp -r ~/.config/gtk-4.0 ./backup
        cp -r ~/.config/satty ./backup

        printf "\e[3mLinking files...\e[0m\n"

        ln -f ./global/hypr/* ~/.config/hypr/
        ln -f ./global/wlogout/* ~/.config/wlogout/
        ln -f ./global/wofi/* ~/.config/wofi/
        ln -f ./global/waybar/* ~/.config/waybar/
        ln -f ./global/fastfetch/* ~/.config/fastfetch/
        ln -f ./global/qt/* ~/.config/qt6ct/colors/
        ln -f ./global/mako/* ~/.config/mako/
        ln -f ./global/gtk-3.0/* ~/.config/gtk-3.0/
        ln -f ./global/gtk-4.0/* ~/.config/gtk-4.0/
        ln -f ./global/satty/* ~/.config/satty/
        
        printf "idk if it linked everything, go test it (and relogin just in case)\n\n"
        main

elif [[ $choice == "3" || $choice == "remove" || $choice == "rm" ]] then
    printf "Please be sure that ./backup/ directory has your previous files before you proceed. \e[0;31;1m\nThis action WILL REMOVE PREVIOUS FILES THAT WERE ~/.config/ AND CAN CAUSE LOSES IF YOU DIDN'T BACKUP YOUR CONFIG FILES. ONLY DO THIS IF YOU ARE SURE THAT ./backup/ HAS ALL YOUR NEEDED FILES.\e[0;37;0m\n"
    read -p "ARE YOU SURE? "
    if [[ -d ./backup ]] then
        printf "\e[3mBackup directory found. Proceeding to removal.\e[0m\n"
        printf "\e[3mDeleting files in ~/.config/ ...\e[0m\n"
        
        rm -rf ~/.config/hypr/
        rm -rf ~/.config/wlogout/
        rm -rf ~/.config/wofi/
        rm -rf ~/.config/waybar/
        rm -rf ~/.config/fastfetch/
        rm -rf ~/.config/qt6ct/colors/
        rm -rf ~/.config/mako/
        rm -rf ~/.config/gtk-3.0/
        rm -rf ~/.config/gtk-4.0/
        rm -rf ~/.config/satty/
        
        printf "\e[3mCopying back old files...\e[0m\n"
        
        cp -r ./backup/hypr ~/.config/hypr
        cp -r ./backup/wlogout ~/.config/wlogout
        cp -r ./backup/wofi ~/.config/wofi
        cp -r ./backup/waybar ~/.config/waybar
        cp -r ./backup/fastfetch ~/.config/fastfetch
        cp -r ./backup/qt6ct ~/.config/
        cp -r ./backup/mako ~/.config/mako
        cp -r ./backup/gtk-3.0 ~/.config/gtk-3.0
        cp -r ./backup/gtk-4.0 ~/.config/gtk-4.0
        cp -r ./backup/satty ~/.config/satty
    fi
else
    main
fi
}

if [[ $(pacman -Qq yay 2> /dev/null ) == "yay" ]] then  
    main
else
    read -p "Please install yay first! Do you want to do it now? (y/n) " choice
    if [[ $choice == "y" || $choice == "yes" || $choice = "ya" ]] then
        sudo pacman -Sy --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si # taken directly from https://github.com/Jguer/yay
        printf "\n"
        main
    elif [[ $choice == "n" || $choice == "no" || $choice == "nah" ]] then
        printf "\n"
        main
    fi
fi

