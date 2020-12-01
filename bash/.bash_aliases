# Unix
alias ll="ls -al"
alias ln="ln -v"
alias e="$EDITOR"
alias v="$VISUAL"

# Bash
alias ls="ls -a"
mkdir () {mkdir -p "$1" && cd "$1"}

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'

# make rum safer
alias rm='rm -iv'

# utils
alias sz="source ~/.zshrc"
killport () {
    matching_ports="$(ps -ax | awk -v to_find="$1" 'OFS="\t" {
                                if ($4 == to_find){print $1, $4};
                                }')"
eval kill  $matching_ports
}


# edit config 
alias es="vim ~/.es_creds && sz"
alias a="vim ~/.dotfiles/bash/.bash_aliases && sz"
alias alk="vim ~/.dotfiles/bash/.bash_aliases"
alias dots="cd ~/.dotfiles"
alias mo="cd ~/sandboxes/mohawk-backend/"

# git commands:
alias glog="git log --oneline --decorate --all --graph"
alias gplog="git log --pretty=format:'%h %an %s'"
alias glast="git add . && git commit --amend && git push --force-with-lease"
alias gstat="git diff main --stat"
alias g="git status"
alias gd="git diff"
alias gb="git branch -a"
alias gp="git push"
alias gpf="git push --force-with-lease"

gco () {git checkout "$1" && git pull}
gr () {git rebase -i "$1"}
gbd () {git branch -D "$1" && git remote prune origin && gb}

# music
alias ms="~/.dotfiles/bash/open_music.sh"
alias endms="~/.dotfiles/bash/close_music.sh"

# dev
alias dev="~/.dotfiles/bash/open_dev.sh"
alias enddev="~/.dotfiles/bash/close_dev.sh"

# tmux
alias aml="sz && dev && tmuxinator start mohawk"
alias tmuxpy="tmuxinator start python"
alias amm="tmuxinator start moneymachine"
alias aga="tmuxinator start ga"




