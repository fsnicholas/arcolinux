#!/bin/bash
#set -e
##################################################################################################################
# Author 	: 	Frank Nicholas
# Date      : 13 June 2020
# Amended so they all call mirrpr with -c AU
##################################################################################################################

# software from  https://github.com/arcolinux/arcolinux-system-config
# software from  https://github.com/arcolinux/arcolinux-systemd-services
# software from  https://github.com/arcolinux/arcolinux-cron           

sudo cp update-mirror.service /usr/lib/systemd/system/
sudo cp update-mirror         /usr/local/bin/
sudo cp mirrorupgrade.hook    /etc/pacman.d/hooks/
sudo cp mirrorlist            /etc/cron.daily

# fsn for pacman claen & zsh
sudo cp zsh.hook                    /etc/pacman.d/hooks/
sudo cp clean_package_cache.hook    /etc/pacman.d/hooks/

sudo systemctl -f enable update-mirror.service
sudo systemctl start update-mirror.service

