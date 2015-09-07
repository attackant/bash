alias sudo='sudo '

alias ls="ls -lAh --color"
alias octal="stat -c '%A %a %n' *"

alias wp-backup="tar -zcvf backup.tgz --exclude-vcs --exclude=wp-content/backup-db/* --exclude=wp-content/cache/* --exclude=wp-content/uploads/cache/* --exclude=wp-content/uploads/shadowbox* --exclude=wp-content/upgrade/* --exclude=wp-content/uploads/wp-clone/* --exclude=wp-content/managewp/* --exclude=wp-content/uploads/backupbuddy_temp/* --exclude=wp-content/uploads/backupbuddy_backups/* --exclude=wp-content/upgrade/* --exclude=wp-content/plugins/ezpz-one-click-backup/* --exclude=cgi-bin/* --exclude=error_log* *"

alias proj="cd /Volumes/mindshare/Projects"
alias play="cd /Volumes/mindshare/Playground"
alias exlib="cd /Volumes/mindshare/External\ Libraries"
alias labs="cd /Volumes/mindshare/Labs\ Projects"

alias wp-quick="wget https://github.com/mindsharestudios/wp-quick-install/archive/master.zip; sudo unzip master.zip; sudo rm -rvf master.zip; echo ' '; echo '======='; echo 'The  latest version of WP Quick Install is ready to run. Remember to delete this folder after your are done.'; echo '======='; ls -lA; "

alias chd755="find . -type d -print0 | sudo xargs -0 chmod 0755"
alias chd775="find . -type d -print0 | sudo xargs -0 chmod 0775"
alias chf664="find . -type f -print0 | sudo xargs -0 chmod 0664"
alias chf644="find . -type f -print0 | sudo xargs -0 chmod 0644"

alias aptup="apt-get update && sudo apt-get dist-upgrade -y"

alias git-pull-all="find . -maxdepth 1 -type d -exec sh -c '(cd {} && git pull)' ';'"
alias git-log="git log --oneline --decorate --graph --max-count=10"
alias gc='git commit -m'
alias gca='git add -A && git commit -am'
alias git-pull-all='find . -maxdepth 1 -type d -exec sh -c '\''(cd {} && git pull)'\'' '\'';'\'''
alias gl='git-log'
alias gs='git status'

