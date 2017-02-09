#!/bin/bash
# Author:  Javier Carretero Casado
# License: Beerware

# Before running this sript on a fresh Ubuntu installation, I recommend you to try it on a virtual machine
# where you may have installed that Ubuntu image.

desktopEnv=$XDG_CURRENT_DESKTOP
if ! [ "$desktopEnv" == "Unity" ] ; then
    echo "This script works for Linux Ubuntu with Unity. You will need to tweak this file to work for other "
    echo "Linux distributions or windows managers. Exiting."
    exit 1
fi

echo "[Updating list of available packages]"
sudo apt update -y -q &> /dev/null

#echo "[Upgrading system packages. This will take a while...]"
#sudo apt -y -q upgrade &> /dev/null

echo
echo "[Installing configuration and basic tools (dconf, gconf-editor, unity-tweak-tool, git, synaptic, zsh)]"
sudo apt-get install -y -q zsh &> /dev/null
chsh -s $(which zsh)
sudo apt-get install -y -q dconf-cli &> /dev/null
sudo apt-get install -y -q dconf-editor &> /dev/null
sudo apt-get install -y -q gconf-editor &> /dev/null
sudo apt-get install -y -q unity-tweak-tool &> /dev/null
sudo apt-get install -y -q git &> /dev/null
sudo apt-get install -y -q synaptic &> /dev/null

#echo "[Installing Slack]"
#sudo apt-get install -y -q slack &> /dev/null  #TODO: Does not work

echo "[Installing Chrome]"
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - &> /dev/null
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q google-chrome-stable &> /dev/null
sudo rm /etc/apt/sources.list.d/google.list

echo "[Installing Spotify]"
# Commands from https://www.spotify.com/es/download/linux/
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 &> /dev/null
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list &> /dev/null
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q spotify-client &> /dev/null

echo "[Installing Rhythmbox and plugins (music player)]"
sudo apt-get install -y -q rhythmbox &> /dev/null
sudo add-apt-repository -y ppa:fossfreedom/rhythmbox-plugins &> /dev/null
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q rhythmbox-plugin-complete &> /dev/null
#TODO: enable plugins through settings

echo "[Installing VLC Media Player]"  #Alternative to Ubuntu GNOME's "Totem" app
sudo apt-get install -y -q vlc &> /dev/null

echo "[Installing Kodi Media Center <3]"
sudo apt-get install -y -q kodi &> /dev/null
#TODO: find prepackaged configuration files

echo "[Installing Transmission for bittorrents]"
sudo apt-get install -y -q transmission &> /dev/null
sudo apt-get install -y -q transmission-qt &> /dev/null

echo "[Installing QBitTorrent]"
sudo add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable &> /dev/null
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q qbittorrent &> /dev/null

#echo "[Installing Thunderbird (e-mail client)]"
#sudo apt-get install -y -q thunderbird &> /dev/null

echo "[Installing Geary (e-mail client, alternative to Thunderbird)]"
sudo apt-get install -y -q geary &> /dev/null
#TODO? Drop geary and use evolution instead?

echo "[Installing Evolution (e-mail client, alternative to Thunderbird) ]"
sudo apt-get install -y -q evolution &> /dev/null

echo "[Installing Darktable photo editor]"
sudo add-apt-repository -y ppa:pmjdebruijn/darktable-release &> /dev/null
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q darktable &> /dev/null

#TODO: Install shotwell

echo "[Installing Pinta (better Paint)]"
sudo apt-get install -y -q pinta &> /dev/null

#echo "[Installing GIMP (Photoshop alternative)]"
#sudo apt-get install -y -q gimp &> /dev/null

#echo "[Installing Inkscape (vector drawing and PDF editor, like LibreOffice Draw - alternative to Adobe Illustrator)]"
#sudo apt-get install -y -q inkscape &> /dev/null

echo "[Installing Evince (PDF viewer and annotator)]"
sudo apt-get install -y -q evince &> /dev/null

#echo "[Installing Okular (PDF viewer and annotator)]"
#sudo apt-get install -y -q okular &> /dev/null

echo "[Installing Pdftk (PDF manipulation)]"
sudo apt-get install -y -q pdftk &> /dev/null

echo "[Installing PDFChain (Pdftk GUI)]"
sudo add-apt-repository -y ppa:pdfchain-team/ppa &> /dev/null
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q pdfchain &> /dev/null

#echo "[Installing Mcomix (comic viewer)]"
#sudo apt-get install -y -q mcomix &> /dev/null

echo "[Installing Qcomicbook (comic viewer)]"
sudo apt-get install -y -q qcomicbook &> /dev/null

echo "[Installing Calibre (ebook reader)]"
sudo apt-get install -y -q calibre &> /dev/null

echo "[Installing Bleachbit (cleaner)]"
sudo apt-get install -y -q bleachbit &> /dev/null

echo "[Installing Oracle's VirtualBox]"
sudo apt-get install -y -q virtualbox-qt &> /dev/null

# ---- editing - programming stuff

echo "[Installing Atom editor]"
sudo add-apt-repository -y ppa:webupd8team/atom &> /dev/null
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q atom &> /dev/null
mkdir -p $HOME/.atom
cat <<EOF > $HOME/.atom/config.cson
"*":
  core:
    telemetryConsent: "no"
    themes: [
      "atom-dark-ui"
      "atom-dark-syntax"
    ]
  editor:
    atomicSoftTabs: false
    lineHeight: 1.3
    preferredLineLength: 110
    showIndentGuide: true
    tabLength: 4
    tabType: "soft"
EOF
# TODO: install + configure packages (linters, debuggers, autocompletion, tools ) [python, bash, C, C++...]
#       And add those files to the repo!

echo "[Installing Remarkable (Markdown editor)]"
wget --quiet https://remarkableapp.github.io/files/remarkable_1.87_all.deb  #FIXME with latest file name
sudo apt-get install -y -q gdebi &> /dev/null
sudo gdebi -q -n remarkable_1.87_all.deb &> /dev/null                        #FIXME with latest file name
\rm remarkable_1.87_all.deb

echo "[Installing Nano and configuring it]"
sudo apt-get install -y -q nano &> /dev/null
#echo "[Configuring Nano]"
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

echo "[Installing Gedit and configuring it]"
# http://askubuntu.com/questions/571877/how-to-change-gedit-preferences-from-terminal
killall gedit &> /dev/null
sudo apt-get install -y -q gedit &> /dev/null
gsettings set org.gnome.gedit.preferences.editor wrap-mode 'none'
gsettings set org.gnome.gedit.preferences.editor display-line-numbers true
gsettings set org.gnome.gedit.preferences.editor highlight-current-line true
gsettings set org.gnome.gedit.preferences.editor insert-spaces true
gsettings set org.gnome.gedit.preferences.editor tabs-size 4
gsettings set org.gnome.gedit.preferences.editor auto-indent true
gsettings set org.gnome.gedit.preferences.editor display-right-margin true
gsettings set org.gnome.gedit.preferences.editor right-margin-position 110
gsettings set org.gnome.gedit.preferences.editor scheme 'oblivion'
gsettings set org.gnome.gedit.preferences.editor use-default-font true
gsettings set org.gnome.gedit.preferences.editor editor-font 'Monospace 11'
gsettings set org.gnome.gedit.preferences.editor display-overview-map true
gsettings set org.gnome.gedit.preferences.editor bracket-matching true

  # Trim trailing whitespaces when saving files (plugin)
  git clone https://github.com/jonleighton/gedit-trailsave &> /dev/null
  pushd . &> /dev/null
  cd gedit-trailsave  && ./install.sh &> /dev/null
  plugins=`gsettings get org.gnome.gedit.plugins active-plugins` ; plugins=${plugins::-1} ;
  plugins="$plugins, 'trailsave']"
  gsettings set org.gnome.gedit.plugins active-plugins "$plugins"
  popd &> /dev/null
  \rm -rf gedit-trailsave

  #Change keybindings to move to new tab from Ctl+Alt+PgUp/Down to Ctrl+PgUp/Down (plugin)
  git clone https://github.com/jefferyto/gedit-control-your-tabs.git &> /dev/null
  cp ./gedit-control-your-tabs/controlyourtabs.plugin ~/.local/share/gedit/plugins
  cp ./gedit-control-your-tabs/controlyourtabs.py ~/.local/share/gedit/plugins
  \rm -rf gedit-control-your-tabs
  plugins=`gsettings get org.gnome.gedit.plugins active-plugins` ; plugins=${plugins::-1} ;
  plugins="$plugins, 'controlyourtabs']"
  gsettings set org.gnome.gedit.plugins active-plugins "$plugins"

  #Add Dracula color theme and enable it (theme)
  mkdir -p $HOME/.local/share/gedit/styles/
  wget --quiet -O $HOME/.local/share/gedit/styles/dracula.xml https://raw.githubusercontent.com/dracula/gedit/master/dracula.xml
  #Patch the 'selection' color to not clash with 'current-line' color (black color) ... fuck that
  sed -i '/selection" value/c\    \<color name="selection" value="#000000"/\>' $HOME/.local/share/gedit/styles/dracula.xml
  gsettings set org.gnome.gedit.preferences.editor scheme 'dracula'


echo "[Installing GIT client]" #gitkraken? gitk?
#TODO
#TODO: meld, tkdiff, and other conflict resolution tools. Look for them


echo "[Configuring Terminal aspect]"
gsettings set org.gnome.Terminal.Legacy.Settings new-terminal-mode 'tab'
gsettings set org.gnome.Terminal.Legacy.Settings tab-position 'bottom'
# Ctrl+PageDown for Next Tab
# Ctrl+PageUp for Previous Tab
# Install Dracula theme
git clone https://github.com/GalaticStryder/gnome-terminal-colors-dracula &> /dev/null
sleep 1
cd gnome-terminal-colors-dracula
sleep 1
profId=$(gsettings get org.gnome.Terminal.ProfilesList default | sed "s/^\([\"']\)\(.*\)\1\$/\2/g")
./install.sh --scheme=Dracula -p :$profId --skip-dircolors
sleep 1
cd ..
rm -rf ./gnome-terminal-colors-dracula

echo "[Installing Guake (Ctr+F12 Terminal)]"
sudo apt-get install -y -q guake &> /dev/null
gconftool-2 --type Integer --set /apps/guake/general/window_height  100
gconftool-2 --type Float   --set /apps/guake/general/window_height_f 100
gconftool-2 --type Integer --set /apps/guake/general/window_width 100
gconftool-2 --type Float   --set /apps/guake/general/window_width_f 100
gconftool-2 --type Integer --set /apps/guake/style/background/transparency 0
gconftool-2 --type Boolean --set /apps/guake/general/use_visible_bell  True
gconftool-2 --type Boolean --set /apps/guake/general/window_losefocus False
gconftool-2 --type Boolean --set /apps/guake/general/window_ontop False
gconftool-2 --type string  --set /apps/guake/style/font/palette_name 'Dracula'
gconftool-2 --type string  --set /apps/guake/style/font/style 'Monospace 13'
gconftool-2 --type Boolean --set /apps/guake/general/use_popup False
timeout 2.5 guake-prefs &> /dev/null  || true
#Add guake to startup applications
sudo ln -s /usr/share/applications/guake.desktop /etc/xdg/autostart/

#https://github.com/zsh-users/
#https://github.com/zsh-users/antigen
echo "[Installing Antigen (plugin manager for zsh)]"
pushd . &> /dev/null
cd ~
git clone https://github.com/zsh-users/antigen.git &> /dev/null
mv antigen .antigen &> /dev/null

git clone git://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions &> /dev/null

#Backup .zshrc if it exists
if [ -f "~/.zshrc" ] ; then
    echo "...backing up .zshrc file to $HOME/.antigen/.zshrc_bck"
    cp ~/.zshrc $HOME/.antigen/.zshrc_bck
fi

#TODO: history limit seems not to be working
#TODO: install music player that allows navigating through artists, playlists, shows albums covers,
#      allows getting cover arts in bulk, can synchronize with external devices and that (secondary):
#      can integrate with spotify, get lyrics, information
#TODO: another image manipulation program (effects) and image navigator
#TODO: change font to Monospace 13 for Gedit, Terminal and Guake. For Gedit, unmark use system font

rm -f ~/.zshrc
cat <<EOF > $HOME/.zshrc
source ~/.antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh). Check them :)
antigen bundle command-not-found
 #antigen bundle git
 #antigen bundle pip
 #antigen bundle pyenv
 #antigen bundle python # what does it do?
 #antigen bundle virtualenvwrapper
antigen bundle web-search
antigen bundle colorize

# Bundles from zsh-users.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search ./zsh-history-substring-search.zsh  #TODO FIXME: ./zsh... is needed?
 #antigen bundle zsh-users/zsh-completions

# Load the theme.
antigen theme agnoster

# Tell antigen that you're done.
antigen apply

# Setup zsh-autosuggestions
#source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh #TODO FIXME: needed?
#TODO FIXME: need to source history-substring too?

# Bind keys.
bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey -e
bindkey '^[[1;9C' forward-word
bindkey '^[[1;9D' backward-word
bindkey "^[[H"    beginning-of-line
bindkey "^[[1;5H" beginning-of-line
bindkey "^[[F"    end-of-line
bindkey "^[[1;5F" end-of-line
#To get bindkeys representation: in a terminal type Ctrl+V, nothing will be shown, then type the key combination

# Exports.
export EDITOR='nano'

# Other.
source ~/.alias
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=black,bold' #fixes guake color clash for zsh-users autosuggestions

export HISTSIZE=25               #History size
export SAVEHIST=0                #Saved history size after logout
#export HISTFILE=~/.zsh_history  #History file (default value)
setopt INC_APPEND_HISTORY        #Append into history file
setopt HIST_IGNORE_DUPS          #Save only one command if 2 common are same and consistent
setopt EXTENDED_HISTORY          #Add timestamp for each entry

EOF
popd &> /dev/null

echo "[Installing Docky dock bar]"
sudo apt-get install -y -q docky &> /dev/null
# Auto-Start
mkdir $HOME/.config/autostart/
cat <<EOF > $HOME/.config/autostart/docky.desktop
[Desktop Entry]
Name=Docky
Type=Application
Exec=docky
Terminal=false
Icon=docky
Comment=The finest dock no money can buy.
NoDisplay=false
Categories=Utility;
X-GNOME-Autostart-enabled=true
EOF
#Configure docklets (Trash, Desktop, Weather)
gconftool-2 --type list --list-type string --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/Plugins ['Trash','Desktop','Weather']
#Add launch icons (.desktop files)
gconftool-2 --type Boolean --set /apps/docky-2/Docky/Interface/DockPreferences/FirstRun False
gconftool-2 --type list --list-type string --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/Launchers ['file:///usr/share/applications/gnome-terminal.desktop','file:///usr/share/applications/nautilus.desktop','file:///usr/share/applications/google-chrome.desktop','file:///usr/share/applications/spotify.desktop','file:///usr/share/ubuntu/applications/org.gnome.Software.desktop','file:///usr/share/applications/qBittorrent.desktop','file:///usr/share/applications/gnome-calculator.desktop']
#gconftool-2 --type list --list-type string --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/SortList  ['/usr/share/applications/gnome-terminal.desktop','/usr/share/applications/nautilus.desktop','/usr/share/applications/google-chrome.desktop','/usr/share/applications/spotify.desktop','/usr/share/ubuntu/applications/org.gnome.Software.desktop','/usr/share/applications/qBittorrent.desktop','/usr/share/applications/gnome-calculator.desktop','TrashCan','Desktop','WeatherDockItem']
gconftool-2 --type list --list-type string --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/SortList  ['/usr/share/applications/gnome-terminal.desktop','/usr/share/applications/nautilus.desktop','/usr/share/applications/google-chrome.desktop','/usr/share/applications/spotify.desktop','/usr/share/ubuntu/applications/org.gnome.Software.desktop','/usr/share/applications/qBittorrent.desktop','/usr/share/applications/gnome-calculator.desktop']
#Configure effects + size
gconftool-2 --type string --set /apps/docky-2/Docky/Services/ThemeService/Theme 'Air'
gconftool-2 --type Boolean --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/ThreeDimensional True
gconftool-2 --type Integer --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/IconSize 75
gconftool-2 --type Float --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/ZoomPercent 2.1
gconftool-2 --type string --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/Autohide 'Intellihide'
gconftool-2 --type Boolean --set /apps/docky-2/Docky/Items/DockyItem/ShowDockyItem False
gconftool-2 --type list --list-type string --set /apps/docky-2/WeatherDocklet/WeatherPreferences/Location ['Barcelona\, spain']
gconftool-2 --type Boolean --set /apps/docky-2/WeatherDocklet/WeatherPreferences/Metric True
gconftool-2 --type Integer --set /apps/docky-2/WeatherDocklet/WeatherPreferences/Timeout 60
nohup docky &> /dev/null &

echo "[Hiding Unity dock (will not disable it)]"
#http://askubuntu.com/questions/643028/shell-script-to-remove-unity-launcherif-present-in-ubuntu-14-04-and-or-the-xf
dconf write /org/compiz/profiles/unity/plugins/unityshell/launcher-hide-mode 1   #0 to enable back
dconf write /org/compiz/profiles/unity/plugins/unityshell/edge-responsiveness 0  #2 to enable back
gsettings set com.canonical.Unity.Launcher favorites [] #gsettings reset com.canonical.Unity.Launcher favorites
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ icon-size 8

echo "[Installing classic Application top menu]"
sudo apt-add-repository -y ppa:diesch/testing  &> /dev/null
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q classicmenu-indicator &> /dev/null

echo "[Installing new Fonts (Powerline)]"
git clone https://github.com/powerline/fonts.git  &> /dev/null
cd fonts
./install.sh &> /dev/null
cd ..
\rm -rf ./fonts
sudo apt-get install -y -q fonts-powerline &> /dev/null
fc-cache -vf &> /dev/null #refresh font cache! (make fonts available)

echo "[Installing 'Paper' GTK theme, icons and cursors]"
sudo add-apt-repository -y ppa:snwh/pulp &> /dev/null
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q paper-icon-theme &> /dev/null
sudo apt-get install -y -q paper-gtk-theme &> /dev/null
sudo apt-get install -y -q paper-cursor-theme &> /dev/null
echo "[Installing 'Flatabulous' GTK theme, icons and cursors]"
sudo add-apt-repository -y ppa:noobslab/themes &> /dev/null
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q flatabulous-theme &> /dev/null
sudo add-apt-repository -y ppa:noobslab/icons &> /dev/null
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q ultra-flat-icons &> /dev/null

echo "[Configuring general aspect]"
gsettings set org.gnome.desktop.interface gtk-theme 'Flatabulous'
gsettings set org.gnome.desktop.interface icon-theme 'Paper'
gsettings set com.canonical.indicator.datetime show-date true
gsettings set com.canonical.indicator.datetime show-year true
gsettings set com.canonical.indicator.power show-percentage true
gsettings set com.canonical.indicator.power show-time true
gsettings set org.gnome.nautilus.icon-view default-zoom-level 'large'
gsettings set org.gtk.Settings.FileChooser show-hidden true
gsettings set com.canonical.Unity always-show-menus false
gsettings set com.canonical.Unity integrated-menus false
#gsettings set org.compiz.animation:/org/compiz/profiles/unity/plugins/animation/ unminimize-effects [\'animation:"Magic Lamp"\'] #"Glide 2" is the original
#gsettings set org.compiz.animation:/org/compiz/profiles/unity/plugins/animation/ minimize-effects [\'animation:"Magic Lamp"\'] #"Zoom" is the original
sudo sh -c "echo 'LC_TIME=\"en_GB.UTF-8\"' >> /etc/default/locale"

#echo "[Changing wallpaper]"
#gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/Cielo_estrellado_by_Eduardo_Diez_Vi%C3%B1uela.jpg

echo "[Changing timezone to Europe/Madrid]"
sudo timedatectl set-timezone Europe/Madrid
# sudo dpkg-reconfigure tzdata   # This will bring up a new window where the user can select it

#echo "[Changing keyboard layout to 'es']"   # and winkeys?
#sudo setxkbmap -layout es  #TODO: Does not work

echo "[Configuring keyboard delays - rates]"
gsettings set org.gnome.desktop.peripherals.keyboard delay 140
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 20
gsettings set org.gnome.desktop.peripherals.keyboard repeat true

# Compressor commands + GUI (peazip)
echo "[Installing compression utilities]"
sudo apt-get install -y -q rar unace p7zip p7zip-full p7zip-rar unrar lzip lhasa arj sharutils mpack lzma lzop cabextract &> /dev/null

#echo "[Installing Skype]"
#sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
#sudo dpkg --add-architecture i386
#sudo apt-get update -y -q &> /dev/null
#sudo apt-get install -y -q skype &> /dev/null

#echo "[Installing Shutter (advanced screenshot capture)]"
#sudo apt-get install -y -q shutter &> /dev/null

# TODO?: screencast recorders (normal and for GIFs)
# TODO?: photo editors
# TODO?: audio editors
# TODO?: video editors
# TODO?: STEAM
# TODO?: DropBox
# TODO?: Gufws
# TODO?: Pomodoro - Tomate
# TODO?: Password manager like KeepPass, but that synchronizes to cloud

# TODO: Windowskey + M to minimize all windows
# TODO: Windowskey + Enter to show windows thumbnails

# TODO: useful aliases like notify-send--> alert, look for others
# TODO: install clementine, and install all plugins for clementine and rhythmbox

sudo apt autoremove -y -q &> /dev/null
sudo apt clean -y -q &> /dev/null
sudo apt-get -y -q autoclean &> /dev/null
echo "[ DONE! Log out from this session and login again to see all the changes. Hope it works! ]"
echo "[ Remember that installed applications can be accessed by clicking on the 'three stacked rectangles' icon (dock at the top left) ]"
echo "[ Or by clicking on the 'Ubuntu Software' icon (dock bar at the bottom) ]"

# TODO: Change default apps for web browser, mail client, music player, video player and photo viewer (don't know how to do that through CLI)
# TODO: Install the latest proprietary Linux graphics drivers available for your hardware
# TODO: Install special restricted extras?


#echo "[Installing Restricted extras and addons (including codecs)]"
#TODO: check what they are installing
#sudo apt-get install -y -q ubuntu-restricted-extras                  #interactive!!
#sudo apt-get install -y -q ubuntu-restricted-addons &> /dev/null
#sudo apt-get install -y -q libdvdcss2 libdvdnav4 libdvdread4  &> /dev/null
#sudo apt-get install -y -q libdvd-pkg &> /dev/null
#sudo dpkg-reconfigure libdvd-pkg &> /dev/null

notify-send "DONE!    :)"
