# Needs to symlink ~/.zshenv -> ~/.config/zsh/.zshenv
# https://specifications.freedesktop.org/basedir-spec/latest/
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# change location of .zshenv, .zshrc, etc. to ~/.config/zsh instead of ~
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
