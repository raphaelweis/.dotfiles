export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  nvm
)

source "$ZSH/oh-my-zsh.sh"

autoload -Uz compinit
compinit

alias ta="tmux attach"
alias la="ls -la"
alias vim="nvim"
alias sslyze="docker run --rm -it nablac0d3/sslyze:latest"

bindkey -e
bindkey -s '^[s' 'tmux-sessionizer\n'

export EDITOR=nvim
export PATH=$PATH:"$HOME/.local/bin":"$HOME/.local/scripts":"$HOME/bin":"$HOME/go/bin"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# opencode
export PATH=/home/raphaelw/.opencode/bin:$PATH

if [[ "$(uname)" = "Darwin" ]]; then
  export NODE_EXTRA_CA_CERTS="$HOME/Documents/ZscalerRootCA.crt"
fi
