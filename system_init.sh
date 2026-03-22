#!/bin/zsh

apt install -y vim stow ca-certificates curl lynx fzf zoxide bat zsh zsh-autosuggestions zsh-syntax-highlighting man command-not-found git surfraw nnn 

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
su seano
chsh -s zsh
git clone https://github.com/seanj29/.dotfiles.git /home/seano/.dotfiles
cd /home/seano/.dotfiles
stow .