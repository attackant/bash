(cd /Volumes/mindshare/Labs\ Projects/bash && git pull && cp -iv ./user/.bash_aliases ~/.bash_aliases)

if [ ! -f ~/.bash_aliases_local ]; then
    touch ~/.bash_aliases_local
fi

source ~/.bashrc
echo "Aliases updated."
