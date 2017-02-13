#!/bin/bash
# Author:  Javier Carretero Casado
# License: Beerware

# Before running this sript on a fresh Ubuntu installation, I recommend you to try it on a virtual machine
# where you may have installed that Ubuntu image.

# TODO?: PyCharm?
# TODO: qt for python ?
# TODO: git confllict resolution tool: meld, tkdiff, kdiff3 and diffuse. Tell git which to use!s

echo "[Updating list of available packages]"
sudo apt update -y -q

echo
echo "[Upgrading system packages. This will take a while...]"
sudo apt upgrade
sudo apt-get dist-upgrade

echo
echo "[Installing Git]"
sudo apt-get install -y -q git &> /dev/null

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

#echo "[Installing Python Pycharm IDE]" # TODO
#wget --quiet https://download.jetbrains.com/python/pycharm-community-2016.3.2.tar.gz
#tar -xvzf pycharm-community-2016.3.2.tar.gz -C /opt/
#\rm pycharm-community-2016.3.2.tar.gz
#TODO: Add pycharm.desktop to docky bar

echo "[Installing Python PyPI (pip)]"
sudo apt-get install -y -q python-pip  &> /dev/null
pip install -q --upgrade pip &> /dev/null

echo "[Installing Python Virtualenv]"
pip install --user -q virtualenv &> /dev/null

## These should be installed under a python virtualenv (once created and activated)
echo "[Installing Python Pandas & Numpy]" #Also installs numpy, python-dateutil, six, pytz, requests
pip install --user -q pandas &> /dev/null
echo "[Installing Plotly]"
pip install --user -q plotly &> /dev/null
echo "[Installing Matplotlib]"
pip install --user -q matplotlib &> /dev/null #Also installs numpy, python-dateutil, six, pytz, cycler, pyparsing
echo "[Installing Colorlover package (for plots)]"
pip install --userr -q colorlover &> /dev/null
echo "[Installing MongoDB library for Python (pymongo)]"
pip install --user -q pymongo &> /dev/null

echo "[Installing buildtools]"
sudo apt-get install -y -q build-essential autoconf automake libtool cmake make &> /dev/null

echo "[Installing GCC, C++, Gfortran, and Fort77]"
sudo apt-get install -y -q gcc g++ gfortran fort77 &> /dev/null

echo "[Installing OpenMPI bin-common and libdev]"
sudo apt-get install -y -q openmpi-bin openmpi-common libopenmpi-dev &> /dev/null

# TODO: Clang
# TODO: Java
sudo apt-get install default-jdk

# Dstat
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

c
