#!/bin/bash
# Author:  Javier Carretero Casado
# License: Beerware

# Before running this sript on a fresh Ubuntu installation, I recommend you to try it on a virtual machine
# where you may have installed that Ubuntu image.

set -e

echo "[Updating list of available packages]"
sudo  apt update -y -q &> /dev/null

echo "[Installing Python 2.7.*]"
sudo apt-get install -y -q python &> /dev/null
#sudo apt-get install -y -q python-dev &> /dev/null

echo "[Installing Python 3.5.*]"
sudo apt-get install -y -q python3.5 &> /dev/null
#sudo apt-get install -y -q python3.5-dev &> /dev/null

echo "[Installing Python Pycharm IDE]"
mkdir -p ~/PyCharm
wget --quiet https://download.jetbrains.com/python/pycharm-community-2017.1.3.tar.gz #FIXME: use latest version
tar -xzf pycharm-community-2017.1.3.tar.gz -C ~/PyCharm
\rm pycharm-community-2017.1.3.tar.gz

pycharmBin=\"$(readlink -e ~/PyCharm/*/bin/pycharm.sh)\"
pycharmPath=$(dirname $(readlink -e ~/PyCharm/*/bin/pycharm.sh))
pycharmIcon=$(readlink -e ~/PyCharm/*/bin/pycharm.png)

cat <<EOF > $HOME/.local/share/applications/pycharm.desktop
[Desktop Entry]
Version=1.0
Type=Application
Name=PyCharm Community Edition
Icon=$pycharmIcon
Exec=$pycharmBin %f
Comment=The Drive to Develop
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-pycharm-ce
EOF

echo "export PATH=\$PATH:$pycharmPath" >> ~/.environment

# Add pycharm.desktop to docky bar (if docky exists)
if which docky &> /dev/null ;
then
    killall docky &> /dev/null || true
    launchers=$(gconftool-2 --get /apps/docky-2/Docky/Interface/DockPreferences/Dock1/Launchers)
    sortlist=$(gconftool-2 --get /apps/docky-2/Docky/Interface/DockPreferences/Dock1/SortList)
    launchers=${launchers::-1}
    launcher="file://$HOME/.local/share/applications/pycharm.desktop"
    launchers="$launchers,$launcher"]
    sortlist=${sortlist::-1}
    newsorted="$HOME/.local/share/applications/pycharm.desktop"
    sortlist="$sortlist,$newsorted"]
    gconftool-2 --type list --list-type string --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/Launchers $launchers
    gconftool-2 --type list --list-type string --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/SortList $sortlist
    nohup docky &> /dev/null &
fi

echo "[Installing Python PyPI (pip)]"
sudo apt-get install -y -q python-pip  &> /dev/null
pip install -q --upgrade pip &> /dev/null

echo "[Installing Python Virtualenv]"
pip install --user -q virtualenv &> /dev/null

sudo apt autoremove -y -q &> /dev/null
sudo apt clean -y -q &> /dev/null
sudo apt-get -y -q autoclean &> /dev/null
echo "[ DONE! ]"

notify-send " DONE!!     :)"
