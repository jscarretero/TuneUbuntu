#!/bin/bash
# Author: Javier Carretero Casado

# TODO: Check we are using Ubuntu GNOME, otherwise exit saying why

echo "[Updating list of available packages]"
sudo apt update -y -q &> /dev/null

echo
echo "[Upgrading system packages. This will take a while...]"
sudo apt -y -q upgrade &> /dev/null

echo
echo "[Installing Dconf-tools]"
sudo apt-get install -y -q dconf-cli > /dev/null
sudo apt-get install -y -q dconf-editor > /dev/null

echo "[Installing Gnome's gconf-editor]"
sudo apt-get install -y -q gconf-editor > /dev/null

echo "[Installing Gnome's tweak tool]"
sudo apt-get install -y -q gnome-tweak-tool > /dev/null

echo "[Installing Synaptic package manager]"
sudo apt-get install -y -q synaptic > /dev/null

echo "[Installing Slack]"
sudo apt-get install -y -q slack > /dev/null

echo "[Installing Spotify]"
# Commands from https://www.spotify.com/es/download/linux/
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 &> /dev/null
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list > /dev/null
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q spotify-client > /dev/null
#TODO: add spotify to dock bar

echo "[Installing Chrome]"
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - &> /dev/null
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q google-chrome-stable > /dev/null
#TODO: add chrome to dock bar

echo "[Installing Transmission for bittorrents]"
sudo apt-get install -y -q transmission > /dev/null
sudo apt-get install -y -q transmission-qt > /dev/null

echo "[Installing QBitTorrent]"
sudo add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable &> /dev/null
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q qbittorrent > /dev/null
#TODO: add qbitrorrent to dock bar

echo "[Installing Oracle's VirtualBox]"
sudo apt-get install -y -q virtualbox-qt > /dev/null

echo "[Installing Restricted extras and addons (including codecs)]"
#TODO: check what they are installing
sudo apt-get install -y -q ubuntu-restricted-extras                  #interactive!!
sudo apt-get install -y -q ubuntu-restricted-addons > /dev/null
sudo apt-get install -y -q libdvdcss2 libdvdnav4 libdvdread4  > /dev/null
sudo apt-get install -y -q libdvd-pkg > /dev/null
sudo dpkg-reconfigure libdvd-pkg > /dev/null
#echo "[Installing Flash Player (flash will soon be unsupported)]"
#sudo apt-get install flashplugin-installer #Not needed for Chrome #already installed by restricted-extras

echo "[Installing VLC Media Player]"  #Alternative to Ubuntu GNOME's "Totem" app
sudo apt-get install -y -q vlc &> /dev/null

echo "[Installing Atom editor]"
sudo add-apt-repository -y ppa:webupd8team/atom &> /dev/null
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q atom > /dev/null
echo "[Configuring Atom editor]"
#TODO: same as nano (tabs to spaces, 4 spaces, max column)

echo "[Installing Darktable photo editor]"
sudo add-apt-repository -y ppa:pmjdebruijn/darktable-release &> /dev/null
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q darktable > /dev/null

echo "[Installing Pinta (better Paint)]"
sudo apt-get install -y -q pinta > /dev/null

echo "[Installing Remarkable (Markdown editor)]"
wget --quiet https://remarkableapp.github.io/files/remarkable_1.87_all.deb  #FIXME with latest file name
sudo apt-get install -y -q gdebi > /dev/null
sudo gdebi -q -n remarkable_1.87_all.deb > /dev/null                        #FIXME with latest file name
\rm remarkable_1.87_all.deb

echo "[Installing GIT client]" #gitkraken? gitk?
#TODO

#TODO: NO: use bash-it instead!!
#echo "[Installing Oh-my-zsh]"
#echo "[Configuring Oh-my-zsh]"
#echo "[...Changing theme]" !!!
#echo "[...Changing plugins]"
#echo "[...Changing fonts]"
#echo "[...Changing color schemes]"s

echo "[Installing new Fonts]" #!!!!
#TODO
echo "[Installing new Icon sets]" # ????
#TODO?

echo "[Configuring terminal aspect]"
#TODO: use tabs instead of new windows
#TODO: install tmux? terminator? screen?
#TODO: disable beep

echo "[Configuring keyboard delays - rates]"
gsettings set org.gnome.desktop.peripherals.keyboard delay 145
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 22
gsettings set org.gnome.desktop.peripherals.keyboard repeat true

echo "[Configuring Gnome]"
echo "[ ...Showing minimize-maximize icons]"
echo "[ ...]"
#TODO

echo "[Adding Gnome shell extensions]"
echo "[Installing 'Paper' Gnome theme]"
sudo add-apt-repository -y ppa:snwh/pulp &> /dev/null
sudo apt-get update -y -q &> /dev/null
echo "[ ... Installing 'Paper' icons]"
sudo apt-get install -y -q paper-icon-theme > /dev/null
echo "[ ... Installing 'Paper' GTK theme]"
sudo apt-get install -y -q paper-gtk-theme > /dev/null
echo "[ ... Installing 'Paper' cursors]"
sudo apt-get install -y -q paper-cursor-theme > /dev/null

echo "[Configuring Gnome shell]"
# TODO: new tab instead of window
# TODO: bell

echo "[Installing Guake (Ctr+F12)]"
sudo apt-get install -y -q guake > /dev/null
echo "[Configuring Guake]"
# TODO:!!!
# TODO: Add guake to startup applications

echo "[Changing wallpaper]"
#wget -q -o "$HOME/Pictures/wallpaper.jpg" http://www.elviajeroazul.top/wp-content/uploads/2016/07/atardecer-magico-fondos-4k-hd-elviajeroazul.top-13.jpg
#if [$? -eq 0 ] ; then
#    gsettings set org.gnome.desktop.background picture-uri "$HOME/Pictures/wallpaper.jpg"
#fi
echo "[Changing lockscreen wallpaper]"
# TODO
echo "[Changing welcome wallpaper]"
# TODO
echo "[Disabling annoying beep sounds]"
# TODO

echo "[Installing Nano]"
sudo apt-get install -y -q nano > /dev/null
echo "[Configuring Nano]"
 echo "include \"/usr/share/nano/*.nanorc\"" >> ~/.nanorc
 echo "set autoindent" >> ~/.nanorc
 echo "set cut" >> ~/.nanorc
 echo "set nowrap" >> ~/.nanorc
 echo "set smooth" >> ~/.nanorc
 echo "set tabsize 4" >> ~/.nanorc
 echo "unset casesensitive" >> ~/.nanorc
 echo "set morespace" >> ~/.nanorc
 echo "unset nonewlines" >> ~/.nanorc
 echo "set tabstospaces" >> ~/.nanorc


echo "[Installing Gedit]"
# http://askubuntu.com/questions/571877/how-to-change-gedit-preferences-from-terminal
killall gedit &> /dev/null
sudo apt-get install -y -q gedit > /dev/null
echo "[Configuring Gedit]"
gsettings set org.gnome.gedit.preferences.editor display-line-numbers true
gsettings set org.gnome.gedit.preferences.editor highlight-current-line true
gsettings set org.gnome.gedit.preferences.editor insert-spaces true
gsettings set org.gnome.gedit.preferences.editor tabs-size 4
gsettings set org.gnome.gedit.preferences.editor auto-indent true
gsettings set org.gnome.gedit.preferences.editor display-right-margin true
gsettings set org.gnome.gedit.preferences.editor right-margin-position 110
gsettings set org.gnome.gedit.preferences.editor scheme 'oblivion'
gsettings set org.gnome.gedit.preferences.editor use-default-font true
gsettings set org.gnome.gedit.preferences.editor editor-font 'Monospace 9'
  # Trim trailing whitespaces when saving files
  git clone https://github.com/jonleighton/gedit-trailsave &> /dev/null
  pushd . &> /dev/null
  cd gedit-trailsave  && ./install.sh &> /dev/null
  plugins=`gsettings get org.gnome.gedit.plugins active-plugins` ; plugins=${plugins::-1} ;
  plugins="$plugins, 'trailsave']"
  gsettings set org.gnome.gedit.plugins active-plugins "$plugins"
  popd &> /dev/null
  \rm -rf gedit-trailsave

echo "[Adding Docky dock bar]"
sudo apt-get install -y -q docky &> /dev/null
echo "[Configuring dock bar]"
# TODO: add icons
# TODO: configure effects + size

echo "[Changing timezone to Europe/Madrid"
sudo timedatectl set-timezone Europe/Madrid
# sudo dpkg-reconfigure tzdata   # This will bring up a new window where the user can select it

#echo "[Changing keyboard layout to 'es']"
#sudo setxkbmap -layout es  #DOES NOT WORK

sudo apt autoremove -y -q &> /dev/null
sudo apt clean -y -q &> /dev/null
sudo apt-get -y -q autoclean &> /dev/null
echo "[ DONE! Log out from this session and login again to see all the changes. Hope it works! ]"

