export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git fzf zsh-autosuggestions zsh-syntax-highlighting)

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
source $ZSH/oh-my-zsh.sh

export ANDROID_HOME=$HOME/Android/Sdk
export CUCUMBER_PUBLISH_QUIET=true
export FZF_ALT_C_COMMAND='fd --type d'

bindkey -s "^[s" "tmux-sessionizer\n"
alias vim='nvim'
alias ta='tmux attach'
