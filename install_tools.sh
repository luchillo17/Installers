#!/bin/bash -x
clear
#export DEBIAN_FRONTEND=noninteractive
# Exit on error
set -o errexit

# Here's inverted commilla just in case `

echo "Start of install"
autoinstall(){
	for var in "$@"; do
		apt-get -y install $var
		if [ $? != 0 ]; then
			echo "$var not installed, error."
			exit 1
		else			
			echo "$var Installed succesfully."
		fi
	done
}

autoupdate(){
	apt-get -y update
	if [ $? != 0 ]; then
		echo "That update didn't work out so well. Trying some fancy stuff..."
		sleep 3
		rm -rf /var/lib/apt/lists/* -vf
		apt-get update -f || echo "The errors have overwhelmed us, bro." && exit
	fi
}

autoupdate
apt-get upgrade
apt-get dist-upgrade && apt-get autoremove

if false; then
apt-cache policy virtualbox
add-apt-repository multiverse
autoupdate
autoinstall virtualbox
fi