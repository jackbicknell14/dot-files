# Unix
alias ll="ls -al"
alias ln="ln -v"
alias mkdir="mkdir -p"
alias e="$EDITOR"
alias v="$VISUAL"

# better bash
alias ls="ls -a"
mkdir () { mkdir "$1" && cd "$1"}

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'

# tmux
alias tmuxpy="tmuxinator start python"
alias amm="tmuxinator start moneymachine"

# git
alias g="git status"
alias gb="git branch -a"
alias gr="git rebase -i master"
alias gf="git add . && git commit --fixup HEAD^ && git rebase -i master
--autosquash && git push --force-with-lease"
alias gp="git push"
alias gpfwl="git push --force-with-lease"
alias glog="git log --oneline --decorate --all --graph"
alias plog="git log --pretty=format:'%h %an %s'"

# make rum safer
alias rm='rm -iv'

# englishscore
alias escreds="sudo vim ~/.es_creds"
