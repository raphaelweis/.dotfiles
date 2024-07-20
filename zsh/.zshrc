# Include hidden files in fzf keybinds
export FZF_CTRL_T_COMMAND="fd --type f --hidden"
export FZF_ALT_C_COMMAND="fd --type d --hidden"

export PATH="$HOME/.local/bin:/usr/local/bin:/usr/local/texlive/2023/bin/x86_64-linux:$PATH"
export MANPATH="/usr/local/man:/usr/local/texlive/2023/texmf-dist/doc/man:$MANPATH"
export INFOPATH="/usr/local/texlive/2023/texmf-dist/doc/info:$INFOPATH"

export EDITOR='nvim'
export VISUAL='nvim'

# source fzf keybindings
source /usr/share/doc/fzf/examples/key-bindings.zsh

# source git completions
autoload -Uz compinit && compinit

eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
