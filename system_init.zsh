#!/bin/zsh

su seano
chsh -s zsh
git clone https://github.com/seanj29/.dotfiles.git /home/seano/.dotfiles
cd /home/seano/.dotfiles
stow .