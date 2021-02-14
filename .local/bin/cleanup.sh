#!/bin/sh

sudo pacman -Syu --clean
paru -Syu --aur --clean
pacman -Qqen > $HOME/.pkglist.txt
pacman -Qqem > $HOME/.foreignpkglist.txt
pip install --upgrade --user $(pip list --outdated --user --format=freeze | cut -f 1 -d =)
pip install --upgrade $(pip list --outdated --format=freeze | cut -f 1 -d =)
