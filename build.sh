#!/bin/bash

ISOFILE=$1
KERNEL=$2
KERNELVERSION=$3

INPUTFOLDER=""
KERNELARGS=" -u "
GRUBOPTIONS="quiet splash acpi_rev_override=1"

# Parse ARGS
POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -k|--kernel)
    echo "Setting kernel version..."
    KERNELVERSION="$2"
    KERNELARGS=" --kernel $KERNELVERSION "
    shift # past argument
    shift # past value
    ;;
    -c|--compatibility)
    echo "Setting compatibility..."
    COMPATIBILITY="$2"
    shift # past argument
    shift # past value
    ;;
    -d|--docker)
    echo "Called from docker..."
    INPUTFOLDER="/docker-input/"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters
# End args parsing

# If missing, download latest version of the script that will respin the ISO
if [ ! -f isorespin.sh ]; then
	echo "Isorespin script not found. Please get a complete copy of this toolkit from"
	echo "https://github.com/stockmind/dell-xps-9560-ubuntu-respin"
	exit 1
fi

installpackages=""

# Packages that differs based on ubuntu version
if [ -n "$COMPATIBILITY" ]; then
	if [ "$COMPATIBILITY" == "bionicbeaver" ]; then
		installpackages+="libva2 "
		installpackages+="bbswitch-dkms "
		installpackages+="pciutils "
		installpackages+="lsb-release "
		# Nvidia
		installpackages+="nvidia-driver-430 "
		installpackages+="nvidia-prime "

		GRUBOPTIONS="quiet splash acpi_rev_override=1 nouveau.modeset=0"
	else
		installpackages+="libva1 "
		# Nvidia
		installpackages+="nvidia-430 "
		installpackages+="nvidia-prime "
	fi
else
	installpackages+="libva1 "
	# Nvidia
	installpackages+="nvidia-430 "
	installpackages+="nvidia-prime "
fi

# Packages that will be installed:
# Thermal management stuff and packages
installpackages+="thermald "
installpackages+="tlp "
installpackages+="tlp-rdw  "
installpackages+="powertop "
# Streaming and codecs for correct video encoding/play
installpackages+="va-driver-all "
installpackages+="vainfo "
installpackages+="gstreamer1.0-libav "
installpackages+="gstreamer1.0-vaapi "
# Useful music/video player with large set of codecs
installpackages+="vlc "

# basic
installpackages+="openssl "
installpackages+="python3 python3-dev python3-pip "
installpackages+="arc-theme "
installpackages+="git git-flow git-lfs "
# installpackages+="gnome-mpv folder-color "
# installpackages+="gnome-shell-extension-appindicator gnome-shell-extension-autohidetopbar gnome-shell-extension-better-volume gnome-shell-extension-caffeine gnome-shell-extension-dashtodock gnome-shell-extension-disconnect-wifi gnome-shell-extension-hard-disk-led gnome-shell-extension-hide-activities gnome-shell-extension-mediaplayer gnome-shell-extension-move-clock gnome-shell-extension-multi-monitors gnome-shell-extension-no-annoyance gnome-shell-extension-pixelsaver gnome-shell-extension-remove-dropdown-arrows gnome-shell-extension-shortcuts gnome-shell-extension-show-ip gnome-shell-extension-suspend-button gnome-shell-extension-system-monitor gnome-shell-extension-taskbar gnome-shell-extension-tilix-dropdown gnome-shell-extension-top-icons-plus gnome-shell-extension-trash gnome-shell-extension-weather gnome-shell-extensions gnome-shell-extensions-gpaste gnome-shell-pomodoro gnome-shell-timer gnome-software gnome-software-common gnome-software-plugin-snap gnome-startup-applications gnome-sushi gnome-terminal gnome-terminal-data gnome-themes-extra gnome-themes-extra-data gnome-tweak-tool gnome-tweaks "
installpackages+="ibus-table-cangjie3 "
installpackages+="imwheel htop httpie "
# installpackages+="tmux "
installpackages+="wget curl "
# installpackages+="tree "
# installpackages+="zsh zsh-syntax-highlighting "
# installpackages+="filezilla chromium-browser "
# installpackages+="p7zip-full "
# installpackages+="docker-ce docker-ce-cli containerd.io "
# installpackages+="pycharm-community "
# installpackages+="slack-desktop "
# installpackages+="spotify-client "
# installpackages+="tmate "
# installpackages+="vscode "

# Packages that will be removed:
#removepackages=""

chmod +x isorespin.sh

sync;

if [ "$COMPATIBILITY" == "xenialxerus" ]; then
	echo "isorespin.sh -i $INPUTFOLDER$ISOFILE"
	wget -O libssl.deb http://mirrors.kernel.org/ubuntu/pool/main/o/openssl/libssl1.1_1.1.0g-2ubuntu4_amd64.deb
	# Xenialxerus require an upgraded libssl to use/install new kernels
	./isorespin.sh -i "$INPUTFOLDER""$ISOFILE" --upgrade -l libssl.deb
	mv linuxium-* $ISOFILE
	INPUTFOLDER=""
fi

echo "isorespin.sh -i $INPUTFOLDER$ISOFILE"

addrepos=""
addrepos+="ppa:daniruiz/flat-remix "
addrepos+="ppa:dhor/myway "
addrepos+="ppa:js-reynaud/kicad-5.1 "
addrepos+="ppa:freecad-maintainers/freecad-stable "
addrepos+="ppa:kritalime/ppa "
addrepos+="ppa:maarten-fonville/android-studio "
addrepos+="ppa:morphis/anbox-support "
addrepos+="ppa:nilarimogard/webupd8 "
addrepos+="ppa:rvm/smplayer "
addrepos+="ppa:snwh/ppa "
addrepos+="ppa:ubuntuhandbook1/apps "
addrepos+="ppa:lyzardking/ubuntu-make "
addrepos+="ppa:mystic-mirage/pycharm "

./isorespin.sh -i "$INPUTFOLDER""$ISOFILE" \
	$KERNELARGS \
	-r "ppa:graphics-drivers/ppa" \
	-r "ppa:daniruiz/flat-remix" \
	-r "ppa:dhor/myway" \
	-r "ppa:js-reynaud/kicad-5.1" \
	-r "ppa:freecad-maintainers/freecad-stable" \
	-r "ppa:kritalime/ppa" \
	-r "ppa:maarten-fonville/android-studio" \
	-r "ppa:morphis/anbox-support" \
	-r "ppa:nilarimogard/webupd8" \
	-r "ppa:rvm/smplayer" \
	-r "ppa:snwh/ppa" \
	-r "ppa:ubuntuhandbook1/apps" \
	-r "ppa:lyzardking/ubuntu-make" \
	-r "deb https://packages.microsoft.com/repos/vscode stable main" --key "adv --keyserver keyserver.ubuntu.com --recv-keys EB3E94ADBE1229CF" \
	-r "deb http://packages.cloud.google.com/apt cloud-sdk-bionic main" --key "adv --keyserver keyserver.ubuntu.com --recv-keys 6A030B21BA07F4FB" \
	-r "deb https://packagecloud.io/slacktechnologies/slack/debian/ jessie main"  --key "adv --keyserver keyserver.ubuntu.com --recv-keys 40976EAF437D05B5" --key "adv --keyserver keyserver.ubuntu.com --recv-keys C6ABDCF64DB9A0B2" \
	-r "https://download.docker.com/linux/ubuntu bionic stable"  --key "adv --keyserver keyserver.ubuntu.com --recv-keys 7EA0A9C3F273FCD8" \
	-p "$installpackages" \
	-f wrapper-network.sh \
	-f wrapper-nvidia.sh \
	-f services/gpuoff.service \
	-c wrapper-network.sh \
	-c wrapper-nvidia.sh \
	-g "" \
	-g "$GRUBOPTIONS"

# dd if=./linuxium-ubuntu-19.04-desktop-amd64.iso of=/dev/sdb bs=999M
