# Include hidden files in fzf keybinds
export FZF_CTRL_T_COMMAND="fd --type f --hidden"
export FZF_ALT_C_COMMAND="fd --type d --hidden"

export PATH="$HOME/.local/bin:/usr/local/bin:/usr/local/texlive/2023/bin/x86_64-linux:$PATH"
export MANPATH="/usr/local/man:/usr/local/texlive/2023/texmf-dist/doc/man:$MANPATH"
export INFOPATH="/usr/local/texlive/2023/texmf-dist/doc/info:$INFOPATH"

export EDITOR='nvim'
export VISUAL='nvim'

# enable vi mode
bindkey -v

# source fzf keybindings
source /usr/share/doc/fzf/examples/key-bindings.zsh

# source git completions
autoload -Uz compinit && compinit

# append the current working directory to the prompt for windows terminal
# see: https://learn.microsoft.com/en-us/windows/terminal/tutorials/new-tab-same-directory
keep_current_path() {
  printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"
}
precmd_functions+=(keep_current_path)

eval "$(starship init zsh)"
