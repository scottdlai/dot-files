local plugin_root_dir="$XDG_DATA_HOME/zsh/plugins"

function zsh-plugin {
    if [ -z "$1" ]; then
        return
    fi

    # username/repo -> repo
    local plugin_name=$(cut -d '/' -f2 <<< "$1")

    local plugin_dir="$plugin_root_dir/$plugin_name"
    local script_name="${2:-$plugin_name.zsh}"

    if [[ ! -d "$plugin_dir" ]]; then
        git clone "https://github.com/$1.git" "$plugin_dir";
    fi

    source "$plugin_dir/$script_name"
}

function zsh-plugin-update {
    for plugin in $plugin_root_dir/*; do
        echo "Updating $(basename $plugin)..."
        git -C "$plugin" pull
    done
}
