# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="${HOME}"/.oh-my-zsh

export PATH="${HOME}"/bin:"${PATH}"
export PATH="${PATH}":"${HOME}"/apps/CodeChecker/bin
export PATH="${PATH}:${HOME}/.krew/bin"
export PATH="${PATH}":"${HOME}"/.emacs.d/bin/
export PATH="${PATH}":"${HOME}"/go/bin
export GOPATH="${HOME}"/go
#export PATH="${HOME}"/.cargo/bin:"${PATH}"

ZSH_THEME="spaceship"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"
plugins=(git globalias)

# Add commands here to skip globalias expansion
declare -a GLOBALIAS_BLKLIST=(git ls config grep)
#plugins=(git)

source $ZSH/oh-my-zsh.sh
#export KUBECONFIG="$HOME"/.kube/hoff073:"$HOME"/.kube/minikube
export KUBECONFIG="$HOME"/.kube/config
export KUBE_EDITOR="emacs"
unsetopt AUTO_CD

export IMS_REPO=/repo/ims-common

. ~/.aliases
. ~/.kubectl-aliases

cl() {
   GREP_COLOR='01;36' grep --color=always 'APP-TRACE' $1 |\
      GREP_COLOR='01;32' grep --color=always "Msg:\".*\"" |\
      GREP_COLOR='01;34' grep --color=always 'pid:' |\
      GREP_COLOR='01;31' grep --color=always "\sid:" |\
      GREP_COLOR='01;35' grep --color=always 'time:' |\
      GREP_COLOR='01;34' grep --color=always 'processname:' |\
      GREP_COLOR='01;33' grep --color=always 'level' |\
      GREP_COLOR='01;31' grep --color=always 'file:' |\
      sed -r 's/(file\:)/\t\t\1/'|\
      less -S -R
}

unzip_d() {
   zipfile="$1"
   zipdir=${1%.zip}
   unzip -d "$zipdir" "$zipfile"
}

pp() {
   jq -C . $1 | less -R
}

_starttmux() {
   if [ -z "$TMUX" ]; then
     tmux attach -t TMUX || tmux new -s MAIN &>/dev/null
   fi
}

export LANG=en_US.UTF-8

EDITOR='emacs'
alias hs='history | grep '
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Personal aliases

ALT_EDITOR=""
e () {
   # Reuse existing frames (don't create a new window)
   # emacsclient -n $@ &>/dev/null &
   emacsclient --create-frame $@ &>/dev/null &
}

alias k=kubectl
source <(kubectl completion zsh)
complete -F __start_kubectl k

source <(helm completion zsh)

_starttmux
