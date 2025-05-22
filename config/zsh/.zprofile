[ -x "/opt/homebrew/bin/brew" ] && eval "$(/opt/homebrew/bin/brew shellenv)"

# Pyenv
export PYENV_ROOT="$XDG_STATE_HOME/.pyenv"
command -v pyenv >/dev/null && eval "$(pyenv init - --zsh)"

# rbenv
export RBENV_ROOT="$XDG_DATA_HOME/rbenv"
command -v rbenv >/dev/null && eval "$(rbenv init - --no-rehash zsh)"

# Java
export JAVA_HOME="/opt/homebrew/opt/openjdk@17"
export PATH="$PATH:$JAVA_HOME/bin"

# Golang
export GOPATH="$XDG_DATA_HOME/go"

function _setup-nvm {
    # This loads nvm
    \. "$NVM_DIR/nvm.sh"

    # place this after nvm initialization!
    autoload -U add-zsh-hook

    load-nvmrc() {
      local nvmrc_path
      nvmrc_path="$(nvm_find_nvmrc)"

      if [ -n "$nvmrc_path" ]; then
        local nvmrc_node_version
        nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

        if [ "$nvmrc_node_version" = "N/A" ]; then
          nvm install
        elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
          nvm use
        fi
      elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
        echo "Reverting to nvm default version"
        nvm use default
      fi
    }

    add-zsh-hook chpwd load-nvmrc
    load-nvmrc
}

# nvm
export NVM_DIR="$XDG_DATA_HOME/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && _setup-nvm
