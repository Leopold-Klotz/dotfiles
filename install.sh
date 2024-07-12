#!/bin/bash
ln -sf ~/dotfiles/.bash_profile ~/.bash_profile
ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

if [ -d ~/dotfiles/bin ]; then
    ln -sf ~/dotfiles/bin ~/bin
fi

if [ -d ~/dotfiles/.config ]; then
    for config in ~/dotfiles/.config/*; do
        ln -sf "" ~/.config/
    done
fi

source ~/.bash_profile
source ~/.bashrc
