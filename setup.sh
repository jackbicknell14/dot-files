!/bin/bash
# run after cloning for the first time
cd ~ 
# mv dot-files ~/.dotfiles
ln ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln ~/.dotfiles/.tmuxinator/ ~/.config/tmuxinator
ln ~/.dotfiles/.zsh/.zshrc ~/.zshrc
ln ~/.dotfiles/vim/.vimrc ~/.vimrc
