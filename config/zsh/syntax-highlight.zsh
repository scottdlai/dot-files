# Declare the variable
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
typeset -A ZSH_HIGHLIGHT_STYLES

# Enable main and cursor highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Change color of highlighted command
ZSH_HIGHLIGHT_STYLES[command]='fg=green'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=green'
ZSH_HIGHLIGHT_STYLES[alias]='fg=blue'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='bold'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='bold'

# Change the color of the character that the cursor is on
ZSH_HIGHLIGHT_STYLES[cursor]='standout'

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
