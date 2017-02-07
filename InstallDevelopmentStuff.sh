#!/bin/bash
# Author:  Javier Carretero Casado
# License: Beerware

# TODO:To add aliases to separate file
PkgCleanup ()      { sudo apt-get -f install && sudo apt-get autoremove && sudo apt-get -y autoclean && sudo apt-get -y clean ; }
PkgUpdate()        { sudo apt update -y -q ; }
PkgUpdateUpgrade() { sudo apt-get upgrade && sudo apt-get dist-upgrade ; }
alias pkg_update="sudo apt-get --only-upgrade install $1"


# TODO?: PyCharm?
# TODO: tkdiff alternative
# TODO: qt for python ?
# TODO: git confllict resolution tool

echo "[Updating list of available packages]"
sudo apt update -y -q

echo
echo "[Upgrading system packages. This will take a while...]"
sudo apt upgrade
sudo apt-get dist-upgrade

echo
echo "[Installing Git]"
sudo apt-get install -y -q git > /dev/null
echo "[Installing Curl]"
sudo apt-get install -y -q curl > /dev/null
echo "[Installing Wget]"
sudo apt-get install -y -q wget > /dev/null
echo "[Installing Tmux]"
sudo apt-get install -y -q tmux > /dev/null
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
sudo apt-get install -y -q screen > /dev/null
echo "[Installing Nmap]"
sudo apt-get install -y -q nmap > /dev/null
echo "[Installing Ctags]"
sudo apt-get install -y -q ctags > /dev/null
echo "[Installing OpenSSL]"
sudo apt-get install -y -q openssl > /dev/null
echo "[Installing OpenSSH client + server]"
sudo apt-get install -y -q openssh-client openssh-server > /dev/null
echo "[Installing Python 2.7.*]"
sudo apt-get install -y -q python > /dev/null
#sudo apt-get install -y -q python-dev > /dev/null
echo "[Installing Python PyPI (pip)]"
sudo apt-get install -y -q python-pip  > /dev/null
echo "[Installing Python Virtualenv]"
sudo pip install -q virtualenv > /dev/null
#echo "[Installing Python Pycharm IDE]" # TODO

  #pip install -q --upgrade pip > /dev/null
  ## These should be installed under a python virtualenv (once created and activated)

  #echo "[Installing Python Pandas & Numpy]"
  #Also installs numpy, python-dateutil, six, pytz, requests
  #pip install -y -q pandas > /dev/null

  #echo "[Installing Plotly]"
  #pip install -y -q plotly > /dev/null

  #echo "[Installing Matplotlib]"
  #Also installs numpy, python-dateutil, six, pytz, cycler, pyparsing
  #pip install -y -q matplotlib > /dev/null

  #echo "[Installing Colorlover package (for plots)]"
  #pip install -y -q colorlover > /dev/null

  #echo "[Installing MongoDB library for Python (pymongo)]
  #pip install -y -q pymongo > /dev/null

'''
sudo apt-get install build-essential autoconf automake libtool ¿cmake?


# OpenMPI
  sudo apt-get install -y -q openmpi-bin openmpi-common libopenmpi-dev > /dev/null

# GCC, C++, Gfortran
  sudo apt-get install -y -q gcc g++ gfortran fort77 > /dev/null

# Clang

# make, configure
  sudo apt-get install cmake

# Java
  sudo apt-get install default-jdk

# Singularity from scratch

# Dstat
    sudo apt-get install dstat
    '''
    echo "[Installing Dstat (system-level performance monitor)]"
    tmpDir=`mktemp -d`
    pushd .
    cd "$tmpDir"
    git clone --quiet https://github.com/dagwieers/dstat.git
    cd dstat
    our_prefix="prefix = /opt/dstat/"
    sed -i "/prefix = \/usr/c $our_prefix" ./Makefile
    ##make
    sudo make install >& /dev/null
    cd /tmp
    rm -rf "$tmpDir"
    sudo ln -s /opt/dstat/share/dstat/  /opt/dstat/bin/plugins
    #FALTA MODIFICAR $PATH
    export PATH="$PATH:/opt/dstat/bin"
    echo "" >> ~/.bashsrc
    echo 'export PATH="$PATH:/opt/dstat/bin"' >> ~/.bashrc
    popd
    '''

# compressors-decompressors + GUI

'''
sudo apt autoremove -y -q > /dev/null
sudo apt clean -y -q > /dev/null
sudo apt-get -y -q autoclean > /dev/null
echo "[Done!]"
