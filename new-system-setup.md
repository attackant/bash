<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Contents**

- [Get sudo rights, setup terminal](#get-sudo-rights-setup-terminal)
- [Install apt applications](#install-apt-applications)
- [Configure bash & git](#configure-bash-&-git)
- [Update current install](#update-current-install)
- [System config](#system-config)
- [Install non-apt applications](#install-non-apt-applications)
- [Setup [SSH](https://help.github.com/articles/generating-ssh-keys/)](#setup-sshhttpshelpgithubcomarticlesgenerating-ssh-keys)
- [Manually configure applications:](#manually-configure-applications)
- [Install essetial non-apt applications](#install-essetial-non-apt-applications)
- [Install all mindshare repos](#install-all-mindshare-repos)
- [Install external libraries](#install-external-libraries)
- [IntelliJ IEA (or PHPStorm) and plugins](#intellij-iea-or-phpstorm-and-plugins)
- [Install dev tools, web stack](#install-dev-tools-web-stack)
    - [Meteor](#meteor)
    - [Setup multiple php versions](#setup-multiple-php-versions)
    - [[nginx](https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-on-debian-7)](#nginxhttpswwwdigitaloceancomcommunitytutorialshow-to-install-linux-nginx-mysql-php-lemp-stack-on-debian-7)
- [Other Installs](#other-installs)
  - [mariadb](#mariadb)
  - [mongodb](#mongodb)
  - [hhvm](#hhvm)
  - [composer](#composer)
  - [wp cli](#wp-cli)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Get sudo rights, setup terminal
1. Add user to sudoers, www-data groups:
```
usermod -a -G www-data damian && usermod -a -G sudo damian
```
2. In terminal preferences > use dark theme variant
3. logoff then logon again to have group changes take effect


## Install apt applications
```
apt-get install sudo
sudo apt-get install -y clipit ufw fail2ban remmina samba openjdk-7-jdk curl pngcrush optipng ruby rubygems-integration font-manager tree tig htop gprename cowsay xclip build-essential apache2 libapache2-mod-fastcgi php5-mysql php5-fpm git wireshark netcat docker mailutils openssl mercurial locate postfix mailutils libsasl2-2 ca-certificates libsasl2-modules firmware-linux firmware-linux-nonfree subversion && sudo apt-get install -y --no-install-recommends gnome-panel
```

## Configure bash & git
```
git config --global user.name "Damian Taggart" && git config --global user.email && damian@mindsharelabs.com && git config --global core.filemode false && git config --global push.default simple
mkdir ~/{"Labs Projects",Projects,"External Libraries","Playground"}
cd ~/Labs\ Projects && git clone https://github.com/attackant/bash.git
cat ./bash/user/.bashrc_additions >> ~/.bashrc
cp ./bash/user/.bash_aliases ~/.bash_aliases
sudo wget https://gitlab.com/meonkeys/meteor-bash-completion/raw/master/meteor -O /etc/bash_completion.d/meteor
source ~/.bashrc
```
## Update current install
`sudo aptup`

## System config
1. Set time to use network time, 24-hour clock

## Install non-apt applications
```
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb && sudo apt-get -f install -y
```

## Setup [SSH](https://help.github.com/articles/generating-ssh-keys/)
```
ssh-keygen -t rsa -C "damian@mindsharelabs.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
xclip -sel clip < ~/.ssh/id_rsa.pub # add to github, gitlab, bitbucket, etc
```
## Manually configure applications:
1. clipit
2. gedit
3. nemo
4. touchpad / mouse

## Install essetial non-apt applications
1. [insync](https://www.insynchq.com/downloads/linux)
2. [dbeaver](http://dbeaver.jkiss.org/download/) (make launcher)
3. [smartgit](http://www.syntevo.com/smartgit/download)
4. [crashplan](https://www.code42.com/crashplan/thankyou/?os=linux)
5. nodejs via nvm:
```
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash # install nvm
nvm install stable
nvm alias default stable
npm install -g bower grunt-cli
```
## Install all mindshare repos
```
labs && curl -s "https://api.github.com/orgs/mindsharestudios/repos?per_page=100" -u "attackant" | ruby -rubygems -e 'require "json"; JSON.load(STDIN.read).each {|repo| %x[git clone #{repo["ssh_url"]} ]}'
```
## Install external libraries
```
exlib && git clone git@github.com:elliotcondon/acf.git && git clone git@github.com:WordPress/WordPress.git
```
## IntelliJ IEA (or PHPStorm) and plugins
[Download IDE](https://www.jetbrains.com/idea/download/)
```
cd ~/Downloads && sudo mkdir /opt/idea && sudo tar -xf ideaIU-*.tar.gz -C /opt/idea && cd /opt/idea && sudo mv idea-IU-*/* .
```

## Install dev tools, web stack

#### Meteor
```
curl https://install.meteor.com/ | sh
```

#### Setup multiple php versions
```
sudo service apache2 stop
sudo apt-get build-dep php5 -y
cd Downloads/ && git clone git@github.com:cweiske/phpfarm.git && sudo mv phpfarm/ /opt/
sudo cp /Volumes/mindshare/Labs\ Projects/bash/scripts/phpfarm-options.sh /opt/phpfarm/src/custom-options.sh
cd /opt/phpfarm/src
sudo ./compile.sh 5.3.29
sudo ./compile.sh 5.4.33
sudo ./compile.sh 5.5.18
sudo ./compile.sh 5.6.2

labs && cd bash/php-install
sudo mkdir /var/www/cgi-bin
sudo cp php-multi-cgi.conf /etc/apache2/conf-available/php-multi-cgi.conf && sudo cp php-cgi-5.3.29 /var/www/cgi-bin/php-cgi-5.3.29 && sudo cp php-cgi-5.4.33 /var/www/cgi-bin/php-cgi-5.4.33 && sudo cp php-cgi-5.5.18 /var/www/cgi-bin/php-cgi-5.5.18 && sudo cp php-cgi-5.6.2 /var/www/cgi-bin/php-cgi-5.6.2 && sudo cp php-dev.conf /etc/apache2/sites-available/php-dev.conf && sudo cp php-dev-ssl.conf /etc/apache2/sites-available/php-dev-ssl.conf
sudo chown -R www-data:www-data /var/www/ && sudo chmod -R 0744 /var/www/cgi-bin

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
echo "127.0.0.1    php53.dev" | sudo tee --append /etc/hosts
echo "127.0.0.1    php54.dev" | sudo tee --append /etc/hosts
echo "127.0.0.1    php55.dev" | sudo tee --append /etc/hosts
echo "127.0.0.1    php56.dev" | sudo tee --append /etc/hosts
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
### mariadb
```
sudo apt-get install python-software-properties software-properties-common
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
sudo add-apt-repository 'deb http://sfo1.mirrors.digitalocean.com/mariadb/repo/10.0/debian wheezy main'
sudo apt-get update && sudo apt-get install mariadb-server
```
### mongodb
```
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
sudo apt-get update && sudo apt-get install -y mongodb-org
sudo service mongod start
```
Optionally, go get Robo Mongo.

### hhvm
```
wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | sudo apt-key add -
echo deb http://dl.hhvm.com/debian jessie main | sudo tee /etc/apt/sources.list.d/hhvm.list
sudo apt-get update && sudo apt-get install hhvm
```
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
