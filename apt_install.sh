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

<<<<<<< HEAD

# update swapiness
sudo bash -c "echo 'vm.swappiness = 15' >> /etc/sysctl.conf"
cat /etc/sysctl.conf

# installpackages+="zsh zsh-syntax-highlighting "
sudo apt install -y zsh zsh-syntax-highlighting

sudo apt install -y code
which code

sudo apt install -y curl
which curl

sudo apt install -y filezilla chromium-browser
which chromium-browser
which filezilla

sudo apt install -y htop
which htop

sudo apt install -y httpie
which httpie
=======
# ibus-table-cangjie3
sudo apt install -y ibus-table-cangjie3
>>>>>>> feature/apt_install_ibus-table-cangjie3
