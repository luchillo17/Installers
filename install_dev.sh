#!/bin/bash -x
clear
#export DEBIAN_FRONTEND=noninteractive
# Exit on error
set -o errexit

# Here's inverted commilla just in case `

# Generate password somehow
read -p "Write default password for all installables: " password
echo "You chosed $password as your password"

echo "Start of install"
autoinstall(){
	for var in "$@"; do
		apt-get -y install $var
		if [[ $? != 0 ]]; then
			echo "$var not installed, error."
			exit 1
		else
			echo "$var Installed succesfully."
		fi
	done
}

autoupdate(){
	apt-get -y update
	if [[ $? != 0 ]]; then
		echo "That update didn't work out so well. Trying some fancy stuff..."
		sleep 3
		rm -rf /var/lib/apt/lists/* -vf
		apt-get update -f || echo "The errors have overwhelmed us, bro." && exit
	fi
}

autoupdate
apt-get upgrade -y
apt-get dist-upgrade -y && apt-get autoremove -y

# Uninstall Mysql
if false;then
service mysql stop  #or mysqld
killall -9 mysql
killall -9 mysqld
apt-get -y remove --purge mysql-server mysql-client mysql-common
apt-get -y autoremove
apt-get -y autoclean
deluser mysql
rm -rf /var/lib/mysql
apt-get -y purge mysql-server-core-5.5
apt-get -y purge mysql-client-core-5.5
fi

# Install apache2 and mysql with secure installation
if false;then
autoinstall apache2
echo "mysql-server-5.5 mysql-server/root_password_again password $password" | debconf-set-selections
echo "mysql-server-5.5 mysql-server/root_password password $password" | debconf-set-selections
autoinstall mysql-server mysql-client

# Pass input to the installer using a here-document
mysql_secure_installation <<EOF
$password
n
Y
Y
Y
Y
EOF
fi

# Remove Postgresql repository to be able to retry install.
rm -f /etc/apt/sources.list.d/pgdg.list

# Install Postgresql - WIP
if true; then
# echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list
echo "deb http://apt.postgresql.org/pub/repos/apt/ utopic-pgdg main" >> /etc/apt/sources.list.d/pgdg.list
wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | apt-key add -
autoupdate
sudo apt-get upgrade
autoinstall postgresql postgresql-9.5 libpq-dev postgresql-client pgadmin3
sudo -u postgres createuser $USER -s
fi


# Install php5 and other php stuff
#autoinstall php5 libapache2-mod-php5 php5-mysql php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-ps php5-pspell php5-recode php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl

# Install Ruby, Rails and RVM, Make sure to use terminal as login shell in the options. - WIP
if false; then
autoinstall xclip autoconf automake bison build-essential curl libapr1 libaprutil1 libc6-dev libltdl-dev libreadline6 libreadline6-dev libsqlite3-0 libsqlite3-dev libssl-dev libtool libxml2-dev libxslt-dev libxslt1-dev libyaml-dev ncurses-dev nodejs openssl sqlite3 zlib1g zlib1g-dev git-core libreadline-dev libcurl4-openssl-dev python-software-properties libffi-dev libgdbm-dev libncurses5-dev
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
#Load RVM into a shell session *as a function*
if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then
  # First try to load from a user install
  source "$HOME/.rvm/scripts/rvm"
elif [[ -s "/usr/local/rvm/scripts/rvm" ]] ; then
  # Then try to load from a root install
  source "/usr/local/rvm/scripts/rvm"
else
  printf "ERROR: An RVM installation was not found.\n"
fi
type rvm | head -1
rvm -v
rvm install 2.2.2
rvm use 2.2.2
rvm use 2.2.2 --default
ruby -v
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install bundler # If get error try this again with --full-index or something like that
gem install rails
gem update
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
fi

exit 0
