#!/bin/bash
# Author:  Javier Carretero Casado
# License: Beerware

# Before running this sript on a fresh Ubuntu installation, I recommend you to try it on a virtual machine
# where you may have installed that Ubuntu image.

set -e

echo "[Installing Restricted extras and addons]"
sudo apt-get install -y -q ubuntu-restricted-addons &> /dev/null
sudo apt-get --no-install-recommends install ubuntu-restricted-extras &> /dev/null
# I have removed the Microsoft Fonts! The package list have been obtained through synaptic
sudo apt-get install -y -q libavcodec-extra libavcodec-ffmpeg-extra56  &> /dev/null
