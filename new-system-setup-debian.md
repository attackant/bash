<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Contents**

- [Create a bootable Debian USB](#create-a-bootable-debian-usb)
- [Get sudo rights, setup terminal](#get-sudo-rights-setup-terminal)
- [Install apt applications](#install-apt-applications)
- [Configure bash & git](#configure-bash--git)
- [Update current install](#update-current-install)
- [Install non-apt applications](#install-non-apt-applications)
- [Setup SSH](#setup-ssh)
- [Manually configure applications:](#manually-configure-applications)
- [Install essetial non-apt applications](#install-essetial-non-apt-applications)
- [IntelliJ IEA (or PHPStorm) and plugins](#intellij-iea-or-phpstorm-and-plugins)
- [Install dev tools, web stack](#install-dev-tools-web-stack)
    - [nginx](#nginx)
- [Other Installs](#other-installs)
  - [mongodb](#mongodb)
  - [composer](#composer)
  - [wp cli](#wp-cli)
  - [Google Fonts](#google-fonts)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Create a bootable Debian USB
```
wget https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/weekly-builds/amd64/iso-cd/firmware-testing-amd64-netinst.iso
sudo fdisk -l
sudo dd if=firmware-testing-amd64-netinst.iso of=/dev/sde bs=4M
sudo sync
```

## Get sudo rights, setup terminal
1. Add user to sudoers, www-data groups:
```
su -
usermod -a -G www-data damian && usermod -a -G sudo damian
```
2. In terminal preferences > use dark theme variant
3. logoff then logon again to have group changes take effect
4. System Settings > Windows > Check "Prevent Focus Stealing"
5. Set time to use network time, 24-hour clock


## Install apt applications
```
apt-get install sudo
sudo apt-get install -y clipit mariadb ufw fail2ban samba curl pngcrush optipng ruby rubygems-integration font-manager tree tig htop gprename cowsay xclip build-essential apache2 git wireshark netcat docker mailutils openssl mercurial locate postfix mailutils ca-certificates firmware-linux firmware-linux-nonfree subversion nemo-fileroller nemo-gtkhash nemo-data && sudo apt-get install -y --no-install-recommends gnome-panel
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

## Install non-apt applications
```
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb && sudo apt-get -f install -y
```

## Setup [SSH](https://help.github.com/articles/generating-ssh-keys/)
```
ssh-keygen -t ed25519 -C "damian@taggart.consulting"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
xclip -sel clip < ssh-add ~/.ssh/id_ed25519 
# add to github, gitlab, bitbucket, etc
```
## Manually configure applications:
1. clipit
2. gedit
3. nemo
4. touchpad / mouse

## Install essetial non-apt applications
1. [insync](https://www.insynchq.com/downloads/linux)
2. [dbeaver](http://dbeaver.jkiss.org/download/) (make launcher)
3. [gitkraken](https://www.gitkraken.com/download/)
4. [crashplan](https://www.code42.com/crashplan/thankyou/?os=linux)
5. nodejs via nvm:
```
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash # install nvm
nvm install stable
nvm alias default stable
npm install -g bower grunt-cli
```
<!--
## Install all mindshare repos
```
labs && curl -s "https://api.github.com/orgs/mindsharestudios/repos?per_page=100" -u "attackant" | ruby -rubygems -e 'require "json"; JSON.load(STDIN.read).each {|repo| %x[git clone #{repo["ssh_url"]} ]}'
```

## Install external libraries
```
exlib && git clone git@github.com:elliotcondon/acf.git && git clone git@github.com:WordPress/WordPress.git
```
-->
## IntelliJ IEA (or PHPStorm) and plugins
[Download IDE](https://www.jetbrains.com/idea/download/)
```
cd ~/Downloads && sudo mkdir /opt/idea && sudo tar -xf ideaIU-*.tar.gz -C /opt/idea && cd /opt/idea && sudo mv idea-IU-*/* .
```

## Install dev tools, web stack

```
sudo service apache2 stop
sudo chown -R www-data:www-data /var/www/ && sudo chmod -R 0744 /var/www/cgi-bin

# todo
sudo mkdir /etc/apache2/ssl
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/apache.key -out /etc/apache2/ssl/apache.crt
sudo chmod 600 /etc/apache2/ssl/*

sudo a2enmod actions fastcgi alias ssl rewrite
sudo a2disconf serve-cgi-bin
sudo a2enconf php-multi-cgi
sudo a2dissite 000-default
sudo a2ensite php-dev-ssl
sudo service apache2 reload
sudo service apache2 restart
cd /var/www && sudo rm -rv html

sudo chmod 775 /var/www && echo "<?php phpinfo(); ?>" > info.php
echo "127.0.0.1    wordpress.dev" | sudo tee --append /etc/hosts
sudo service apache2 restart

```
#### [nginx](https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-on-debian-7)
```
sudo service apache2 stop && sudo apt-get install nginx
sudo sed -i "/^cgi.fix_pathinfo/c\cgi.fix_pathinfo=0" /etc/php5/fpm/php.ini
sudo service php5-fpm restart && sudo service nginx start
# remove nginx from auto starting on boot, for apache
sudo update-rc.d -f nginx remove && sudo update-rc.d apache2 enable

```
## Other Installs
### mongodb
```
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/5.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list
sudo apt-get update && sudo apt-get install -y mongodb-org
sudo service mongod start
```
Optionally, go get Robo Mongo.

### composer
```
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
```
### wp cli
```
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar && sudo mv wp-cli.phar /usr/local/bin/wp
cd ~ && wget https://github.com/wp-cli/wp-cli/raw/master/utils/wp-completion.bash
```

### Google Fonts
`curl https://raw.githubusercontent.com/qrpike/Web-Font-Load/master/install_debian.sh | sh`
