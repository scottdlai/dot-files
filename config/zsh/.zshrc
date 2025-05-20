# Enable colors
autoload -U colors && colors

# Prompt
source "$ZDOTDIR/prompt.zsh"

# History
export HISTFILE="$XDG_STATE_HOME/zsh/zsh_history"
export HISTDUP="erase"
export HISTSIZE=5000
export SAVEHIST=5000
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

export VISUAL="nvim"
export EDITOR=$VISUAL

export CLICOLOR=1

# use default colors
export LSCOLORS=
export LS_COLORS=

export ZSH_COMPDUMP="$XDG_STATE_HOME/zsh/zcompdump"

# Basic auto/tab complete:
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d "$ZSH_COMPDUMP"
_comp_options+=(globdots) # Include hidden files.

# Simple plugin manager
source "$ZDOTDIR/plugin.zsh"

# Vi mode for zsh
source "$ZDOTDIR/vim.zsh"

# aliases
source "$ZDOTDIR/alias.zsh"

# functions
for function in $ZDOTDIR/functions/*.zsh; do
  source $function
done

# Other
for file in $ZDOTDIR/other/*.zsh; do
  source $file
done

# Syntax highlighting
source "$ZDOTDIR/syntax-highlight.zsh"
