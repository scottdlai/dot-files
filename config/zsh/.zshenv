# Needs to symlink ~/.config/zsh/.zshenv -> ~/.zshenv
eval "$(/opt/homebrew/bin/brew shellenv)"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Homebrew (brew doctor)
PATH="/opt/homebrew/bin:$PATH"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export RBENV_ROOT="$XDG_DATA_HOME/rbenv"

# Ruby
PATH="$PATH:$RBENV_ROOT"

# Java
export JAVA_HOME="/opt/homebrew/opt/openjdk@17"
PATH="$PATH:$JAVA_HOME/bin"


export PATH GOPATH GOROOT
