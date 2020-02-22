#!/bin/bash
# run after cloning for the first time
cd ..
mv dotfiles ~/.dotfiles
ln -s ~/.dotfiles/bash/bash_profile ~/.bash_profile
source ~/.bash_profile
