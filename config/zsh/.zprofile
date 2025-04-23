eval "$(/opt/homebrew/bin/brew shellenv)"

# Pyenv
export PYENV_ROOT="$XDG_STATE_HOME/.pyenv"
eval "$(pyenv init - -zsh)"

# Ruby
export RBENV_ROOT="$XDG_DATA_HOME/rbenv"
eval "$(rbenv init - --no-rehash zsh)"

# Java
export JAVA_HOME="/opt/homebrew/opt/openjdk@17"
export PATH="$PATH:$JAVA_HOME/bin"

# Golang
export GOPATH="$XDG_DATA_HOME/go"
