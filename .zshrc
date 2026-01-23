HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

autoload -U compinit; compinit

alias la="ls -la"
alias zed='zeditor'
alias ta='tmux attach'
alias ts='tmux-sessionizer'

bindkey -e

export EDITOR="zeditor --wait"
export N_PREFIX=$HOME/.n
export PATH=$PATH:"$HOME/.local/bin":"$HOME/.local/scripts":"$HOME/bin":"$HOME/go/bin":"$HOME/.opencode/bin":"$N_PREFIX/bin"

# zsh plugins
if [[ ! -d "$HOME/.zsh/zsh-syntax-highlighting" ]] then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.zsh/zsh-syntax-highlighting
fi
if [[ ! -d "$HOME/.zsh/zsh-autosuggestions" ]] then
  git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.zsh/zsh-autosuggestions
fi

source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source <(fzf --zsh)

if [[ "$(uname)" = "Darwin" ]]; then
  export NODE_EXTRA_CA_CERTS="$HOME/Documents/ZscalerRootCA.crt"
fi

eval "$(starship init zsh)"
