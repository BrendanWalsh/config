set -g -x fish_greeting ""

alias src="source ~/.config/fish/config.fish"
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias cls="clear ;and ls -a --color=auto"
alias gs="git status"
alias gd="git diff"
alias apt="sudo apt-get"
alias kk=kubectl

eval (ssh-agent -c)
ssh-add ~/.ssh/github
