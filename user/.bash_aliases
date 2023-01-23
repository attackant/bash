alias sudo='sudo '                      # alias sudo so that we can use it here
alias ls="ls -lAh --color"              # pretty directory listings
alias octal="stat -c '%A %a %n' *"      # shows octal file and directory permissions
alias proj="cd ~/projects"
alias exlib="cd ~/libraries"

# Generic way to get short service status from list of service names
function status () {
    for name in $@; do \
      echo ${name} $(systemctl is-active ${name}) $(systemctl is-enabled ${name}); \
      done | column -t | grep --color=always '\(disabled\|inactive\|$\)'
}

# Local dev server utils
alias start-web="sudo service mariadb start && sudo service nginx start && sudo service php8.2-fpm start"
alias stop-web="sudo service mariadb stop && sudo service nginx stop && sudo service php8.2-fpm stop"
alias status-web="status mariadb nginx php8.2-fpm"
alias restart-web="sudo service mariadb restart && sudo service nginx restart && sudo service php8.2-fpm restart"

# WordPress file backup without cache folders
alias wp-backup="tar -zcvf wp-backup.tgz --exclude-vcs --exclude=wp-content/backup-db/* --exclude=wp-content/cache/* --exclude=wp-content/uploads/cache/* --exclude=wp-content/uploads/shadowbox* --exclude=wp-content/upgrade/* --exclude=wp-content/uploads/wp-clone/* --exclude=wp-content/managewp/* --exclude=wp-content/uploads/backupbuddy_temp/* --exclude=wp-content/uploads/backupbuddy_backups/* --exclude=wp-content/upgrade/* --exclude=wp-content/plugins/ezpz-one-click-backup/* --exclude=cgi-bin/* --exclude=error_log* *"

# recursive permission changes
alias chd755="find . -type d -print0 | sudo xargs -0 chmod 0755"
alias chd775="find . -type d -print0 | sudo xargs -0 chmod 0775"
alias chf664="find . -type f -print0 | sudo xargs -0 chmod 0664"
alias chf644="find . -type f -print0 | sudo xargs -0 chmod 0644"

# full upgrades with apt-get
alias aptup="apt-get update && sudo apt-get dist-upgrade -y"

# asus fan speed modes, see: https://askubuntu.com/questions/1254364/how-to-control-fans-on-an-asus-laptop
alias fan-turbo='cd /sys/devices/platform/asus-nb-wmi; sudo sh -c "echo 1 >>  fan_boost_mode"; sudo sh -c "echo 1 >> throttle_thermal_policy"; source ~/.bashrc; cd ~;'
alias fan-performance='cd /sys/devices/platform/asus-nb-wmi; sudo sh -c "echo 0 >>  fan_boost_mode"; sudo sh -c "echo 0 >> throttle_thermal_policy"; source ~/.bashrc; cd ~;'
alias fan-silent='cd /sys/devices/platform/asus-nb-wmi; sudo sh -c "echo 2 >>  fan_boost_mode"; sudo sh -c "echo 2 >> throttle_thermal_policy"; source ~/.bashrc; cd ~;'

# git aliases
alias git-pull-all="find . -maxdepth 1 -type d -exec sh -c '(cd {} && git pull)' ';'"
alias git-log="git log --graph --max-count=10 --decorate --pretty=format:'%C(auto)%h%Creset %Cblue%cr%Creset %s (%Cred%an%Creset) %C(auto)%d'"
alias gc='git commit -m'
alias gca='git add -A && git commit -am'
alias git-pull-all='find . -maxdepth 1 -type d -exec sh -c '\''(cd {} && git pull)'\'' '\'';'\'''
alias gl='git-log'
alias gs='git status'
alias grm-ignored='git ls-files -i --exclude-from=.gitignore | xargs git rm --cached'
alias grm-unstaged='git clean -df && git checkout -- .'

# sends an email with the contents of stdout
alias mail-output='mail -s "$(date "+cli output %m/%d/%Y $PWD")" damian@taggart.consulting'
