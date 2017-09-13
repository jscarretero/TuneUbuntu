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
echo "export JAVA_HOME=$JAVA_HOME" >> ~/.environment

#TODO
alias useJava8=yes | sudo apt-get install  -y -q oracle-java8-set-default &> /dev/null && export JAVA_HOME="$(jrunscript -e 'java.lang.System.out.println(java.lang.System.getProperty("java.home"));')"

# Install Maven

    # Install Gradle

    # Install Ant


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
DESK=/usr/share/applications/IDEA.desktop

wget -cO ${DEST} ${URL} --read-timeout=5 --tries=0

if mkdir ${DIR}; then
    tar -xzf ${DEST} -C ${DIR} --strip-components=1
fi

chmod -R +rwx ${DIR}
#echo "[Desktop Entry]\nEncoding=UTF-8\nName=IntelliJ IDEA\nComment=IntelliJ IDEA\nExec=${BIN}/idea.sh\nIcon=${BIN}/idea.png\nTerminal=false\nStartupNotify=true\nType=Application" -e > c

#TODO: check
cat <<EOF > ${DESK}
[Desktop Entry]
Encoding=UTF-8
Name=IntelliJ IDEA
Comment=IntelliJ IDEA
Exec=${BIN}/idea.sh
Icon=${BIN}/idea.png
Terminal=false
StartupNotify=true
Type=Application
EOF

ln -s ${BIN}/idea.sh /usr/local/bin/idea

#TODO: Add to dock bar

sudo apt autoremove -y -q &> /dev/null
sudo apt clean -y -q &> /dev/null
sudo apt-get -y -q autoclean &> /dev/null

echo "[ DONE! ]"
notify-send " DONE!!     :)"

