eval "$(/opt/homebrew/bin/brew shellenv)"

# Pyenv
export PYENV_ROOT="$XDG_STATE_HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - -zsh)"

# Ruby
export RBENV_ROOT="$XDG_DATA_HOME/rbenv"
export PATH="$PATH:$RBENV_ROOT"

# Java
export JAVA_HOME="/opt/homebrew/opt/openjdk@17"
export PATH="$PATH:$JAVA_HOME/bin"
