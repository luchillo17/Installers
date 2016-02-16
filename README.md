# Installers

The bash files provided in this repository install certain packages and configurations autoatically, tested in Ubuntu 14.10 and 15.04.
I recommend using alongside with systemback just to be careful in case it breaks something, run with 'sudo bash _file_.sh' .

# Disclaimer

Use with care, i tested in Ubuntu 14.10 and 15.04 but i'm no pro bash scripter, test in Virtual Box before or use Systemback as precaution, i don't make responsible if this breaks something just because you didn't look what it does.

# Config files .bash_profile and .bashrc

This files are configs for Linux and Mac, only tested in Ubuntu, most of it is inside of .bash_profile, lots of aliases and functions to make bash better.

Inside .bashrc are some config like terminal colors and some exports for usual heroku binary, `.bash_profile` include this file so it runs on login and non logged bash session, Linux ussually just starts a non-logged session in bash, while Mac by default starts a logged terminal, including `.bash_rc` in `.bash_profile` will keep behavior consistent in logged as well as non-logged bash sessions.

# editors.sh

The bash file editors.sh install Sublime text 3 and Package Control, then copy the 'Package Control.sublime-settings' file inside the sublime packages and Package Control will take care of everything else on re-open of Sublime.

# install_dev.sh

Full web development tools install, takes a few parameters so check before using for commented lines or if statements with false values that deactivates some installing features.

Tools install included in this bash script:
Apache2.
Uninstall for MySQL # Useful for me when testing the installer, false by default.
MySQL/Postgresql 9.3.
MySQL secure installation # Think of a password for your database.
Xclip # Needed for the SSH key to copy to clipboard to put in github, bitbucket or whatever with the configure_dev.sh, makes easyer to copy the ssh key.
RVM # Stands for Ruby Version Manager.
Ruby 2.2.2 # You can change the version if there's a new one or the install method change.
Bundle and Rails # You need Bundle for rails.
Heroku tool belt # Install but not configure, you're on your own on this one.

# configure_dev.sh

This one configure git, create and copy SSH key and then you can paste the key in github, bitbucket or whatever, also set your terminal prompt to display colors if possible.
