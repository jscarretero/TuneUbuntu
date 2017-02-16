#!/bin/bash
# Author:  Javier Carretero Casado
# License: Beerware

# Before running this sript on a fresh Ubuntu installation, I recommend you to try it on a virtual machine
# where you may have installed that Ubuntu image.

set -e

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

