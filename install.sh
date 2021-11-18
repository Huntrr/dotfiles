#!/bin/bash
###############################################
# This script:                                #
# 1) creates symlinks from the home directory #
#    to any desired dotfiles in ~/dotfiles    #
# 2) installs zsh                             #
###############################################

set -e

# Variables
dir="$(dirname $0)"
olddir=~/dotfiles_old
platform=$(uname);

# Script
brew_url=https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
install_packagemanager () {
  echo "Updating package manager"
  if [[ $platform == 'Linux' ]]; then
    sudo apt-get update
  elif [[ $platform == 'Darwin' ]]; then
    which -s brew
    if [[ $? != 0 ]]; then
        echo "Homebrew installation"
        /bin/bash -c "$(curl -fsSL $brew_url)"
    else
        brew update
    fi
  fi
}

install_node () {
  echo "Node installation"
  if [[ $platform == 'Linux' ]]; then
    sudo apt-get install nodejs
  elif [[ $platform == 'Darwin' ]]; then
    brew install node
  fi
}

install_zsh () {
  echo "Zshell installation"
  if [ ! -f /bin/zsh -o -f /usr/bin/zsh ]; then
    if [[ $platform == 'Linux' ]]; then
      sudo apt-get install git curl
      sudo apt-get install zsh autojump
    elif [[ $platform == 'Darwin' ]]; then
      brew install zsh autojump ripgrep
    fi
  else
    echo "... skipping"
  fi
}

zsh_url=https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
install_oh_my_zsh () {
  echo "Oh My Zsh installation"
  sh -c "$(curl -fsSL $zsh_url)"
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
}

install_neovim () {
  echo "Neovim installation"
  if [[ $platform == 'Linux' ]]; then
    sudo add-apt-repository ppa:neovim-ppa/stable
    sudo apt-get update
    sudo apt-get install neovim
    sudo apt-get install python-dev python-pip python3-dev python3-pip
  elif [[ $platform == 'Darwin' ]]; then
    brew install neovim
  fi
  python3 -m pip install --user --upgrade pynvim
}

install_vimplug () {
  echo "Vim-Plug installation"
  if [[ -e ~/.vim/autoload/plug.vim ]]; then
    echo "... skipping for vim"
  else
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi

  if [[ -e ~/.local/share/nvim/site/autoload/plug.vim ]]; then
    echo "... skipping for neovim"
  else
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi
}

install_tmux () {
  echo "TMux installation"
  if [[ $platform == 'Linux' ]]; then
    sudo apt-get install tmux
  elif [[ $platform == 'Darwin' ]]; then
    brew install tmux
  fi
}

symlink_dotfiles () {
  echo "Backups and symlinks"
  mkdir -p $olddir
  for file in ./*; do
    file=$(basename $file)
    echo $file
    [ -e "$file" ] || continue
    [ "$file" != "install.sh" ] || continue
    [ "$file" != "readme.md" ] || continue
    if [ -e "${HOME}/.$file" ]; then
      echo "... backing up ~/.$file"
      mv ~/.$file ~/dotfiles_old/
    fi
    echo "...... creating symlink to $file in home directory."
    ln -fs $(pwd)/$file ~/.$file
  done
}

# change to the dotfiles directory
echo "Changing to the $dir directory ..."
cd $dir

install_packagemanager
install_node
install_zsh
install_oh_my_zsh
install_neovim
install_vimplug
install_tmux
symlink_dotfiles
echo "Done!"

