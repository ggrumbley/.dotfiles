#!/usr/bin/env bash

# Exist if any command returns with non-zero exit status fail.
set -e

function header() {
  printf "\n======================================================================\n"
  printf "$1"
  printf "\n======================================================================\n"
}

sudo lshw -c display

header "Install NVIDIA Drivers..."
read -p "Press enter to continue"

header "Update and Upgrade the system with contrib and non-free"
sudo add-apt-repository 'deb http://ftp.debian.org/debian stretch-backports main contrib non-free'
sudo apt install software-properties-common
sudo add-apt-repository contrib
sudo add-apt-repository non-free
sudo apt update
sudo apt upgrade -y

header "Installing NVIDIA Drivers"
sudo apt install nvidia-driver || sudo apt install -t stretch-backports nvidia-driver


header "Restarting..."
sudo shutdown -r now
