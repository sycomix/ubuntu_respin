#!/bin/bash

# https://code.visualstudio.com/docs/setup/linux
cd /usr/local/bin

sudo curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt-get install -y apt-transport-https
sudo apt-get update
sudo apt-get install -y code # or code-insiders


# add custom repository
sudo add-apt-repository -y ppa:daniruiz/flat-remix
sudo add-apt-repository -y ppa:dhor/myway
sudo add-apt-repository -y ppa:js-reynaud/kicad-5.1
sudo add-apt-repository -y ppa:freecad-maintainers/freecad-stable
sudo add-apt-repository -y ppa:kritalime/ppa
sudo add-apt-repository -y ppa:maarten-fonville/android-studio
sudo add-apt-repository -y ppa:morphis/anbox-support
sudo add-apt-repository -y ppa:nilarimogard/webupd8
sudo add-apt-repository -y ppa:rvm/smplayer
sudo add-apt-repository -y ppa:snwh/ppa
sudo add-apt-repository -y ppa:ubuntuhandbook1/apps
sudo add-apt-repository -y ppa:lyzardking/ubuntu-make

# docker
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable"
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
