# Enable colors
autoload -U colors && colors

# Prompt
[ -f "$ZDOTDIR/prompt.zsh" ] && source "$ZDOTDIR/prompt.zsh"

# History
export HISTFILE="$XDG_STATE_HOME/zsh/zsh_history"
export HISTDUP="erase"
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

export LSCOLORS=exfxcxdxbxegedabagacad

export ZSH_COMPDUMP="$XDG_STATE_HOME/zsh/zcompdump"

# Basic auto/tab complete:
export FPATH="$FPATH:$XDG_DATA_HOME/completions"
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d $ZSH_COMPDUMP
_comp_options+=(globdots) # Include hidden files.

# Vi mode for zsh
[ -f "$ZDOTDIR/vim.zsh" ] && source "$ZDOTDIR/vim.zsh"

# fzf
[ -f "$ZDOTDIR/fzf-config.zsh" ] && source "$ZDOTDIR/fzf-config.zsh"

# aliases
[ -f "$ZDOTDIR/alias.zsh" ] && source "$ZDOTDIR/alias.zsh"

# functions
for function in $ZDOTDIR/functions/*.zsh; do
  source $function
done

# Git integration
[ -f "$ZDOTDIR/git-integration.zsh" ] && source "$ZDOTDIR/git-integration.zsh"

# Other
for file in $ZDOTDIR/other/*.zsh; do
  source $file
done

# Syntax highlighting
[ -f "$ZDOTDIR/syntax-highlight.zsh" ] && source "$ZDOTDIR/syntax-highlight.zsh"
