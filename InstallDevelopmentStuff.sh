#!/bin/bash
# Author:  Javier Carretero Casado
# License: Beerware

# Before running this sript on a fresh Ubuntu installation, I recommend you to try it on a virtual machine
# where you may have installed that Ubuntu image.

set -e

echo "[Updating list of available packages]"
sudo  apt update -y -q &> /dev/null

#echo
#echo "[Upgrading system packages. This will take a while...]"
#sudo apt -y -q upgrade &> /dev/null
#sudo apt-get -y -q dist-upgrade &> /dev/null

echo
echo "[Installing Git]"
sudo apt-get install -y -q git tig &> /dev/null

echo "[Installing meld, tkdiff and diffuse]" # TODO: Tell git which one to use! meld or diffuse
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

echo "[Installing OpenSSL]"
sudo apt-get install -y -q openssl &> /dev/null

echo "[Installing OpenSSH client + server]"
sudo apt-get install -y -q openssh-client openssh-server &> /dev/null

echo "[Installing Ctags]"
sudo apt-get install -y -q ctags &> /dev/null

echo "[Installing buildtools]"
sudo apt-get install -y -q build-essential autoconf automake libtool cmake make &> /dev/null

echo "[Installing GCC, C++, Gfortran, and Fort77]"
sudo apt-get install -y -q gcc g++ gfortran fort77 &> /dev/null

echo "[Installing Clang]"
sudo apt-get install -y -q clang &> /dev/null

#echo "[Installing OpenMPI bin-common and libdev]"
#sudo apt-get install -y -q openmpi-bin openmpi-common libopenmpi-dev &> /dev/null

echo "[Installing Dstat (system-level performance monitor)]"
sudo apt-get install -y -q dstat &> /dev/null
#    echo "[Installing Dstat (system-level performance monitor) - manual install]"
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
#    echo "" >> ~/.environment
#    echo 'export PATH="$PATH:/opt/dstat/bin"' >> ~/.environment

sudo apt autoremove -y -q &> /dev/null
sudo apt clean -y -q &> /dev/null
sudo apt-get -y -q autoclean &> /dev/null
echo "[ DONE! ]"

notify-send " DONE!!     :)"
