<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Setup for WSL2 Development](#setup-for-wsl2-development)
  - [Get sudo rights, setup terminal](#get-sudo-rights-setup-terminal)
  - [Install apt applications](#install-apt-applications)
  - [Configure bash & git](#configure-bash--git)
  - [Update current install](#update-current-install)
  - [Install non-apt applications](#install-non-apt-applications)
  - [Setup SSH](#setup-ssh)
  - [Manually configure applications:](#manually-configure-applications)
  - [Install external libraries](#install-external-libraries)
  - [Install dev tools, web stack](#install-dev-tools-web-stack)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->



# Setup for WSL2 Development

## Get sudo rights, setup terminal
1. Add user to sudoers, www-data groups:
```
su -
usermod -a -G www-data damian && usermod -a -G sudo damian
```

## Install apt applications
```
apt-get install sudo
sudo apt-get install -y curl pngcrush optipng tree tig htop gprename cowsay xclip build-essential apache2 git wireshark netcat docker mailutils openssl mercurial locate postfix mailutils libsasl2-2 ca-certificates libsasl2-modules subversion
```

## Configure bash & git
```
git config --global user.name "Damian Taggart" && git config --global user.email && damian@taggart.consulting && git config --global core.filemode false && git config --global push.default simple
mkdir ~/{projects,libraries}
cd ~/projects && git clone https://github.com/attackant/bash.git
cat ./bash/user/.bashrc_additions >> ~/.bashrc
cp ./bash/user/.bash_aliases ~/.bash_aliases
source ~/.bashrc
```
## Update current install
`sudo aptup`

## Setup [SSH](https://help.github.com/articles/generating-ssh-keys/)
```
ssh-keygen -t rsa -C "damian@meowwolf.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
xclip -sel clip < ~/.ssh/id_rsa.pub # add to github, gitlab, bitbucket, etc
```
## Manually configure applications:
nodejs via nvm:
```
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash # install nvm
nvm install stable
nvm alias default stable
npm install -g bower grunt-cli
```

## Install external libraries
```
exlib && git clone git@github.com:elliotcondon/acf.git && git clone git@github.com:WordPress/WordPress.git
```

## Install dev tools, web stack
TODO