# Needs to symlink ~/.zshenv -> ~/.config/zsh/.zshenv
eval "$(/opt/homebrew/bin/brew shellenv)"

# https://specifications.freedesktop.org/basedir-spec/latest/
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# change location of .zshenv, .zshrc, etc. to ~/.config/zsh instead of ~
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Homebrew (brew doctor)
export PATH="/opt/homebrew/bin:$PATH"
# Postgresql 15
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

# Ruby
export RBENV_ROOT="$XDG_DATA_HOME/rbenv"
export PATH="$PATH:$RBENV_ROOT"

# Java
export JAVA_HOME="/opt/homebrew/opt/openjdk@17"
export PATH="$PATH:$JAVA_HOME/bin"

# Pyenv
export PYENV_ROOT="$XDG_STATE_HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# functions
for function in $ZDOTDIR/functions/*.zsh; do
  source $function
done
