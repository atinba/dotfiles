#!/usr/bin/env bash

DOTF=~/.dotfiles/.config

ln -s ~/.config/nvim "$DOTF/nvim" 
ln -s ~/.config/hypr "$DOTF/hypr" 
ln -s ~/.config/fish "$DOTF/fish" 

# ln -sf ~/.dotfiles

