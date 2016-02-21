#!/bin/bash -x
clear
#export DEBIAN_FRONTEND=noninteractive
# Exit on error
set -o errexit

# Here's inverted commilla just in case `

read -p "Write default user for git: " gitusr
read -p "Write default email for git: " gitemail
echo "You chosed $gitusr as your user and $gitemail as email for git."

echo "Start of install"

# Configure git
if true; then
echo "force_color_prompt=yes" >> .bashrc
git config --global color.ui true
git config --global user.name $gitusr
git config --global user.email $gitemail
git config --global alias.co checkout
git config --global alias.com commit
git config --global alias.st status
git config --global alias.br branch
git config --global core.autocrlf input #Proper end line management by git
ssh-keygen -t rsa -C $gitemail
ssh-add ~/.ssh/id_rsa
xclip -sel clip < ~/.ssh/id_rsa.pub
echo "Paste the ssh-key we have put on your clipboard into your github account."
echo "run this to assure that git is correctly configured: ssh -T git@github.com"
fi
