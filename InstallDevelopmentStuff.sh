#!/bin/bash
# Author:  Javier Carretero Casado
# License: Beerware

# Before running this sript on a fresh Ubuntu installation, I recommend you to try it on a virtual machine
# where you may have installed that Ubuntu image.

echo "[Updating list of available packages]"
sudo apt update -y -q &> /dev/null

echo
echo "[Upgrading system packages. This will take a while...]"
sudo apt -y -q upgrade &> /dev/null
sudo apt-get -y -q dist-upgrade &> /dev/null

echo
echo "[Installing Git]"
sudo apt-get install -y -q git &> /dev/null

echo "[Installing meld, tkdiff and diffuse]" #Tell git which one to use! meld or diffuse
sudo apt-get install -y -q meld tkdiff diffuse &> /dev/null  #Install kdiff3? needs kde runtime :S

echo "[Installing Curl]"
sudo apt-get install -y -q curl &> /dev/null

echo "[Installing Wget]"
sudo apt-get install -y -q wget &> /dev/null

echo "[Installing Tmux]"
sudo apt-get install -y -q tmux &> /dev/null
#Ctrl+b+%        : creates vertical split
#Ctrl+b+"        : creates horizontal split
#Ctrl+b+spacebar : changes layouts
#Ctrl+b+x        : kills split
#Ctrl+b+up/dwn/left/right: move between splits
#Ctr+b+d         : dettach from current session
#Ctrl+b+$        : rename current session
#tmux attach -t session-name: joins session 'session-name'
#http://askubuntu.com/questions/8653/how-to-keep-processes-running-after-ending-ssh-session

echo "[Installing Screen]"
sudo apt-get install -y -q screen &> /dev/null

echo "[Installing Nmap]"
sudo apt-get install -y -q nmap &> /dev/null

echo "[Installing Ctags]"
sudo apt-get install -y -q ctags &> /dev/null

echo "[Installing OpenSSL]"
sudo apt-get install -y -q openssl &> /dev/null

echo "[Installing OpenSSH client + server]"
sudo apt-get install -y -q openssh-client openssh-server &> /dev/null

echo "[Installing Python 2.7.*]"
sudo apt-get install -y -q python &> /dev/null
#sudo apt-get install -y -q python-dev &> /dev/null

echo "[Installing Python Pycharm IDE]"
mkdir -p ~/PyCharm
wget --quiet https://download.jetbrains.com/python/pycharm-community-2016.3.2.tar.gz #FIXME: use latest version
tar -xzf pycharm-community-2016.3.2.tar.gz -C ~/PyCharm
\rm pycharm-community-2016.3.2.tar.gz

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

grep -q "PyCharm" ~/.environment || echo "export PATH=\$PATH:$pycharmPath" >> ~/.environment

# Add pycharm.desktop to docky bar (if docky exists)
if which docky &> /dev/null ;
then
    echo "MODIFYING DOCKY REGISTRY""
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
fi


echo "[Installing Python PyPI (pip)]"
sudo apt-get install -y -q python-pip  &> /dev/null
pip install -q --upgrade pip &> /dev/null

echo "[Installing Python Virtualenv]"
pip install --user -q virtualenv &> /dev/null

# Packages to be available under no virtualenv
#echo "[Installing Python Pandas & Numpy]" #Also installs numpy, python-dateutil, six, pytz, requests
#pip install --user -q pandas &> /dev/null
#echo "[Installing Plotly]"
#pip install --user -q plotly &> /dev/null
#echo "[Installing Matplotlib]"
#pip install --user -q matplotlib &> /dev/null #Also installs numpy, python-dateutil, six, pytz, cycler, pyparsing
#echo "[Installing Colorlover package (for plots)]"
#pip install --userr -q colorlover &> /dev/null
#echo "[Installing MongoDB library for Python (pymongo)]"
#pip install --user -q pymongo &> /dev/null
# TODO?: pythonqt lib and dependences

# If we want some Python packages available under a virtualenv, these are the steps:
#   - virtualenv myenv
#   - cd myenv && source bin/activate
#   - pip install -r requirements.txt (where requirements has per each line something like this paramiko == 2.0.0)
#   - Or: pip install paramiko ....

echo "[Installing buildtools]"
sudo apt-get install -y -q build-essential autoconf automake libtool cmake make &> /dev/null

echo "[Installing GCC, C++, Gfortran, and Fort77]"
sudo apt-get install -y -q gcc g++ gfortran fort77 &> /dev/null

echo "[Installing Clang]"
sudo apt-get install -y -q clang &> /dev/null

#echo "[Installing OpenMPI bin-common and libdev]"
#sudo apt-get install -y -q openmpi-bin openmpi-common libopenmpi-dev &> /dev/null

echo "[Installing Java Open JDK 8]"
sudo apt-get install -y -k default-jdk &> /dev/null #Open JDK 8
#sudo add-apt-repository -y ppa:webupd8team/java &> /dev/null
#sudo apt update -y -q &> /dev/null
#sudo apt-get install -y -q oracle-java9-installer # &> /dev/null
#https://www.digitalocean.com/community/tutorials/como-instalar-java-con-apt-get-en-ubuntu-16-04-es
# sudo update-alternatives --config java # To choose java version to use

echo "[Installing Dstat (system-level performance monitor)]"
sudo apt-get install -y -q dstat &> /dev/null
#    echo "[Installing Dstat (system-level performance monitor)]"
#    tmpDir=`mktemp -d`
#    pushd . &> /dev/null
#    cd "$tmpDir"
#    git clone --quiet https://github.com/dagwieers/dstat.git
#    cd dstat
#    our_prefix="prefix = /opt/dstat/"
#    sed -i "/prefix = \/usr/c $our_prefix" ./Makefile
#    ##make
#    sudo make install >& /dev/null
#    popd &> /dev/null
#    rm -rf "$tmpDir"
#    sudo ln -s /opt/dstat/share/dstat/  /opt/dstat/bin/plugins
#    export PATH="$PATH:/opt/dstat/bin"
#    echo "" >> ~/.bashsrc
#    echo 'export PATH="$PATH:/opt/dstat/bin"' >> ~/.bashrc

sudo apt autoremove -y -q &> /dev/null
sudo apt clean -y -q &> /dev/null
sudo apt-get -y -q autoclean &> /dev/null
echo "[ DONE! ]"

notify-send " DONE!!     :)"
