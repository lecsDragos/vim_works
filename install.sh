#!/bin/bash

VIMFOLDER=~/.vim
VIMRC=~/.vimrc

ANSI_RED_BOLD='\033[0;31;1m'
ANSI_GREEN='\033[32m'
ANSI_RESET='\033[0m'

check_vim_folder() {
  if [ -d $VIMFOLDER ]
  then
    echo "$ANSI_RED_BOLD You already have a .vim folder in your home directory. $ANSI_RESET"
    read -p "Would you like to backup your .vim folder first? [y/n] " ans
    if [ "$ans" == "y" ]
    then
      echo "backup your original $VIMFOLDER to $VIMFOLDER-$(date +%Y%m%d)-$RANDOM"
      mv $VIMFOLDER $VIMFOLDER-$(date +%Y%m%d)-$RANDOM
    else
      exit
    fi
  fi
}

check_vimrc_folder() {
  if [ -L $VIMRC ] || [ -f $VIMRC ]
  then
    echo -e "$ANSI_RED_BOLD There's .vimrc in your home directory. $ANSI_RESET"
    read -p "Would you like to backup your .vimrc first? [y/n] " ans
    if [ "$ans" == "y" ]
    then
      echo "backup your original $VIMRC to $VIMRC-$(date +%Y%m%d)-$RANDOM"
      mv $VIMRC $VIMRC$(date +%Y%m%d)-$RANDOM
    else
      exit
    fi
  fi
}

check_git_availability() {
  hash git >/dev/null && /usr/bin/env git clone git@github.com:swammerdamn/vim_works.git $VIMFOLDER || {
    echo "Sorry, git is not installed in this machine."
    exit
  }
}

create_symlinks() {
  echo "creating symlinks ..."
  ln -s $VIMFOLDER/vimrc $VIMRC
}

start_setup() {
  cd $VIMFOLDER
  sh ./update.sh
}

check_vim_folder
check_vimrc_folder
check_git_availability
create_symlinks
start_setup

echo ""
echo -e "$ANSI_GREEN Instalation complete! Enjoy vim ;) $ANSI_RESET"
echo ""

exit
