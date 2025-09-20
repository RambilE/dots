#!/bin/bash
# 1. check deps
# 2. install
# 3. remove



# text stuff
tclr () { printf "\e[0;37;0m" ; }
tred () { printf "\e[0;31;1m" ; }
tgrn () { printf "\e[0;32;1m" ; }
tita () { printf "\e[3m" ; }

if ! [[ $(pwd) == $( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd ) ]] then
    printf "$(tred)Please run this script from the folder that you've installed it into.$(tclr)\n"
    exit
fi

source config.sh
ignorepkgs
dependencies

#ignorelist=( $(grep -Ev '^(;|#|//)' ignorelist) )

for target in "${ignorelist[@]}"; do
  for i in "${!deplist[@]}"; do
    if [[ ${deplist[i]} = $target ]]; then
      unset 'deplist[i]'
    fi
  done
done

clear
printf "$(tgrn)RambilE .files installation helper script (github.com/RambilE/dots)$(tclr)\n"

if ! [[ $(echo ${ignorelist[@]}) == "" ]] then
    printf "$(tred)The following packages are to be ignored: $(echo ${ignorelist[@]})$(tclr)\n" | fold -s -w 80
else
    printf "$(tred)No packages to ignore in ignorelist file$(tclr)\n"
fi

function main {
    printf "1. Check deps\n2. Install dots\n3. Remove dots\n4. Lua update (if possible)\n"
read -p "Your choice: " choice

# deps
if [[ $choice == "1" || $choice == "deps" || $choice == "check deps" ]] then
    printf "Checking dependencies...\n\n"
       
    err=()
    for dep in "${deplist[@]}";
    do
        if ! [[ $(pacman -Qq $dep 2> /dev/null) == "$dep" ]] then
            printf "$(tred)$dep was not found!$(tclr)\n"
            err+=($dep)
        fi
    done

    if ! [[ $err == "" ]] then
        read -p "Dependencies are missing! install them now? (y/n) " choice
        if [[ $choice == "y" || $choice == "yes" || $choice = "ya" ]] then
            yay -Sy ${err[@]}
            printf "\n\n"
            main
        elif [[ $choice == "n" || $choice == "no" || $choice == "nah" ]] then
            printf "\n\n"
            main
        else
            exit 0
        fi
    else
        printf "$(tita)All dependencies are installed!$(tclr)\n\n"
        main
    fi

elif [[ $choice == "2" || $choice == "install" ]] then
        printf "This will link files from ./global/ to where they need to be. This will also copy all relevant dotfiles to ./backup/ dir, and copy it somewhere if you will install multiple times. Please be sure that you're installing this from the same block device that your ~/.config/ directory is as it is hard links. \n\n" | fold -s -w 80
        read -n 1 -s -r -p "Press any key to continue"

        
        printf "$(tita)\n\nBacking up files...$(tclr)\n"
        mkdir backup 2> /dev/null
        cp -r ~/.config/hypr ./backup
        cp -r ~/.config/wlogout ./backup
        cp -r ~/.config/wofi ./backup
        cp -r ~/.config/waybar ./backup
        cp -r ~/.config/fastfetch ./backup
        cp -r ~/.config/mako ./backup
        cp -r ~/.config/foot ./backup
        cp -r ~/.config/nvim ./backup
        cp -r ~/.config/swayimg ./backup

        printf "$(tita)Creating directories...$(tclr)\n"
        mkdir -p ~/.config/hypr \
                 ~/.config/wlogout \
                 ~/.config/wofi \
                 ~/.config/waybar \
                 ~/.config/fastfetch \
                 ~/.config/mako \
                 ~/.config/foot \
                 ~/.config/hypr/rambile/dotscripts \
                 ~/.config/hypr/rambile/wall \
                 ~/.config/nvim \
                 ~/.config/swayimg
                 
        printf "$(tita)Linking files...$(tclr)\n"

        ln -f ./global/hypr/* ~/.config/hypr/
        ln -f ./global/wlogout/* ~/.config/wlogout/
        ln -f ./global/wofi/* ~/.config/wofi/
        ln -f ./global/waybar/* ~/.config/waybar/
        ln -f ./global/fastfetch/* ~/.config/fastfetch/
        ln -f ./global/mako/* ~/.config/mako/
        ln -f ./global/foot/* ~/.config/foot/
        ln -f ./global/rambile/wall/* ~/.config/hypr/rambile/wall
        ln -f ./global/rambile/dotscripts/* ~/.config/hypr/rambile/dotscripts
        ln -f ./global/nvim/init.lua ~/.config/nvim/
        ln -f ./global/swayimg/config ~/.config/swayimg/
        
        printf "\nidk if it linked everything, go test it (and relogin just in case)\nAfter installation you should go to qt6ct and nwg-look to apply catppuccin themes.\n\n"
        main

elif [[ $choice == "3" || $choice == "remove" || $choice == "rm" ]] then
    printf "Please be sure that ./backup/ directory has your previous files before you proceed. $(tred)\nThis action WILL REMOVE PREVIOUS FILES THAT WERE ~/.config/ AND CAN CAUSE LOSES IF YOU DIDN'T BACKUP YOUR CONFIG FILES. ONLY DO THIS IF YOU ARE SURE THAT ./backup/ HAS ALL YOUR NEEDED FILES.$(tclr)\n" | fold -s -w 80
    read -p "ARE YOU SURE? "
    read -n 1 -s -r -p "Press any key to continue"
    if [[ -d ./backup ]] then
        printf "$(tita)Backup directory found. Proceeding to removal.$(tclr)\n"
        printf "$(tita)Deleting files in ~/.config/ ...$(tclr)\n"
        
        rm -rf ~/.config/hypr/
        rm -rf ~/.config/wlogout/
        rm -rf ~/.config/wofi/
        rm -rf ~/.config/waybar/
        rm -rf ~/.config/fastfetch/
        rm -rf ~/.config/mako/
        rm -rf ~/.config/foot/
        rm -rf ~/.config/nvim/
        rm -rf ~/.config/swayimg/
        
        printf "$(tita)Copying back old files...$(tclr)\n"
        
        cp -r ./backup/hypr ~/.config/hypr
        cp -r ./backup/wlogout ~/.config/wlogout
        cp -r ./backup/wofi ~/.config/wofi
        cp -r ./backup/waybar ~/.config/waybar
        cp -r ./backup/fastfetch ~/.config/fastfetch
        cp -r ./backup/mako ~/.config/mako
        cp -r ./backup/foot ~/.config/foot
        cp -r ./backup/nvim ~/.config/nvim
        cp -r ./backup/swayimg ~/.config/swayimg
        
        main
    fi
elif [[ $choice == "4" || $choice == "lua" || $choice == "lua update" ]] then
    ./luastuff.sh
    echo
    main
else
    main
fi
}

if [[ $(which yay) ]] then  
    echo 
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

if [[ $(pacman -Qq luarocks 2> /dev/null ) == "luarocks" ]] then  
    main
else
    read -p "Please install lua libs first! Do you want to do it now? (y/n) " choice
    if [[ $choice == "y" || $choice == "yes" || $choice = "ya" ]] then
        ./luastuff.sh
        main
    elif [[ $choice == "n" || $choice == "no" || $choice == "nah" ]] then
        printf "\n"
        main
    fi
fi
