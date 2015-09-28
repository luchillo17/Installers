#!/bin/bash -x
clear

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

if true;then
autoupdate
apt-get upgrade
apt-get dist-upgrade && apt-get autoremove

add-apt-repository ppa:webupd8team/sublime-text-3
autoupdate
autoinstall sublime-text-installer
wget https://packagecontrol.io/Package%20Control.sublime-package -P ~/.config/sublime-text-3/Installed\ Packages/

ln -s /opt/sublime_text/sublime_text /usr/local/bin/subl
autoinstall p7zip-full
subl

# Install extra packages
touch ~/.config/sublime-text-3/Packages/User/Package\ Control.sublime-settings
cp Package\ Control.sublime-settings ~/.config/sublime-text-3/Packages/User/
cp Preferences.sublime-settings ~/.config/sublime-text-3/Packages/User/
fi
exit 0
