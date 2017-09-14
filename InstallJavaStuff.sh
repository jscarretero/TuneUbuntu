#!/bin/bash
# Author:  Javier Carretero Casado
# License: Beerware

# Before running this sript on a fresh Ubuntu installation, I recommend you to try it on a virtual machine
# where you may have installed that Ubuntu image.

set -e

# Install Oracle JDK 8 and Oracle Docs
# https://askubuntu.com/questions/740757/switch-between-multiple-java-versions
# https://askubuntu.com/questions/521145/how-to-install-oracle-java-on-ubuntu-14-04
# http://tipsonubuntu.com/2016/07/31/install-oracle-java-8-9-ubuntu-16-04-linux-mint-18/
# https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-get-on-ubuntu-16-04
sudo add-apt-repository -y ppa:webupd8team/java  &> /dev/null
sudo apt-get update  -y -q &> /dev/null
sudo apt-get install -y -q java-common &> /dev/null
sudo apt-get install -y -q oracle-java8-installer
sudo apt-get install -y -q oracle-java8-set-default  &> /dev/null
sudo add-apt-repository -r ppa:webupd8team/java

# sudo apt install oracle-java8-set-default #does more things than the commands below
echo >> ~/.environment
JAVA_HOME="$(jrunscript -e 'java.lang.System.out.println(java.lang.System.getProperty("java.home"));')"
echo "export JAVA_HOME=$JAVA_HOME" >> ~/.environment   #FIXME siempre?

echo "      source ~/.java_alias" >> ~/.zshrc

# Install Maven
sudo apt-get install -y -q maven &> /dev/null

echo "[Installing IntelliJ IDEA]"
# https://stackoverflow.com/questions/30130934/how-to-install-intellij-idea-on-ubuntu
# http://breandan.net/2014/08/18/shell-script/

ed=C  # IMPORTANT: Enter 'U' for Ultimate or 'C' for Community:
VERSION=$(wget "https://www.jetbrains.com/intellij-repository/releases" -qO- | grep -P -o -m 1 "(?<=https://www.jetbrains.com/intellij-repository/releases/com/jetbrains/intellij/idea/BUILD/)[^/]+(?=/)")
URL="https://download.jetbrains.com/idea/ideaI$ed-$VERSION.tar.gz"
FILE=$(basename ${URL})
DEST=~/Downloads/$FILE
DIR="/opt/idea-I$ed-$VERSION"
BIN="$DIR/bin"
DESK=/usr/share/applications/IDEA.desktop #CHANGE FIXME

wget -qcO ${DEST} ${URL} --read-timeout=5 --tries=0

sudo mkdir -p ${DIR} &> /dev/null
sudo tar -xzf ${DEST} -C ${DIR} --strip-components=1
sudo chmod -R +rwx ${DIR}

echo "[Desktop Entry]\nEncoding=UTF-8\nName=IntelliJ IDEA\nComment=IntelliJ IDEA\nExec=${BIN}/idea.sh\nIcon=${BIN}/idea.png\nTerminal=false\nStartupNotify=true\nType=Application" -e | sudo tee ${DESK} &> /dev/null

DESK=$HOME/.local/share/applications/IDEA.desktop
cat <<EOF > $DESK
[Desktop Entry]
Encoding=UTF-8
Name=IntelliJ IDEA
Comment=IntelliJ IDEA
Exec=${BIN}/bin/idea.sh
Icon=${BIN}/idea.png
Terminal=false
StartupNotify=true
Type=Application
EOF

sudo ln -s -f ${BIN}/idea.sh /usr/local/bin/idea

# Add IDEA.desktop to docky bar (if docky exists)
if which docky &> /dev/null ;
then
    killall docky &> /dev/null || true
    launchers=$(gconftool-2 --get /apps/docky-2/Docky/Interface/DockPreferences/Dock1/Launchers)
    sortlist=$(gconftool-2 --get /apps/docky-2/Docky/Interface/DockPreferences/Dock1/SortList)
    launchers=${launchers::-1}
    launcher="file://$DESK"
    launchers="$launchers,$launcher"]
    sortlist=${sortlist::-1}
    newsorted="$DESK"
    sortlist="$sortlist,$newsorted"]
    gconftool-2 --type list --list-type string --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/Launchers $launchers
    gconftool-2 --type list --list-type string --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/SortList $sortlist
    echo $launchers
    echo $sortlist
    nohup docky &> /dev/null &
fi

sudo apt autoremove -y -q &> /dev/null
sudo apt clean -y -q &> /dev/null
sudo apt-get -y -q autoclean &> /dev/null

echo "[ DONE! ]"
notify-send " DONE!!     :)"

