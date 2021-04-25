# !/bin/bash

# dev installs
# firefox, iterm2, spotify, postman, whatsapp, slack
# pgAdmin4, pycharm, emacs, xcode, whatsapp, android studio
# vs code, redis, postgresql12, 

# music installs
# splice, logic pro x, metronome x

# run after cloning for the first time
cd ~ 
mv dot-files ~/.dotfiles
cd ~

# install homebrew
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew update
brew install spotify --cask
brew install htop
brew install httpie

# tmux and tmuxinator
brew install tmux
brew install tmuxinator

# oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# pyenv
curl https://pyenv.run | bash

# heroku
brew tap heroku/brew && brew install heroku
heroku autocomplete

# symbolic links

ln ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
mdkir ~/.config
ln -s  ~/.dotfiles/tmuxinator ~/.config/
ln -s  ~/.dotfiles/init ~/
ln ~/.dotfiles/zsh/.zshenv ~/.zshenv
ln ~/.dotfiles/zsh/.zshrc ~/.zshrc
ln ~/.dotfiles/vim/.vimrc ~/.vimrc
