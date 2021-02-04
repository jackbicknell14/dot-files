# !/bin/bash
# run after cloning for the first time
cd ~ 
# mv dot-files ~/.dotfiles
# mkdir .config/tmuxinator
# cd ~

ln ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -s  ~/.dotfiles/.tmuxinator/ ~/.config/tmuxinator
ln ~/.dotfiles/.zsh/.zshrc ~/.zshrc
ln ~/.dotfiles/vim/.vimrc ~/.vimrc
