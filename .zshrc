# .zshrc: executed by zsh for non-login shells.

# Set up the prompt
autoload -Uz promptinit
promptinit

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

# Set TERM
export TERM=xterm

# Source git-prompt.sh if it exists
if [ -f ~/dotfiles/git-prompt.sh ]; then
    source ~/dotfiles/git-prompt.sh
fi

# Set up the prompt with git information
setopt PROMPT_SUBST
if [ "$TERM" = "xterm" ] || [ "$TERM" = "xterm-color" ] || [ "$TERM" = "screen" ] || [ "$TERM" = "screen-256color" ]; then
    PROMPT='%F{green}[%n@%m%f$(__git_ps1 " (%s)") %F{red}%~%f%#%F{green}]%f '
else
    PROMPT='[%n@%m$(__git_ps1 " (%s)") %~%#] '
fi

# Enable color support
autoload -U colors && colors

# Set up aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# OS-specific aliases
if [[ "$OSTYPE" == "darwin"* ]]; then
    export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
    alias ls='ls -G'
else
    alias ls='ls --color'
fi

alias ll='ls -alF'
alias la='ls -als'
alias l='ls -ls'
alias scr='screen -T xterm-color'
alias tmux='TERM=xterm-256color tmux'
alias gdb='gdb -q'

# Load alias definitions from .zsh_aliases if it exists
if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
fi

# Set PATH
export PATH="/usr/local/bin:$HOME/bin:$PATH"

# Set up key bindings
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# Set up completion
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Ensure the terminal is in application mode when zle is active
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init() {
        echoti smkx
    }
    function zle-line-finish() {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi
