function zsh-plugin {
    if [ -z "$1" ]; then
        return
    fi

    # username/repo -> repo
    local plugin_name=$(cut -d '/' -f2 <<< "$1")

    local plugin_dir="$XDG_DATA_HOME/zsh/plugins/$plugin_name"
    local script_name="${2:-$plugin_name.zsh}"

    if [[ ! -d "$plugin_dir" ]]; then
        git clone "https://github.com/$1.git" "$plugin_dir";
    fi

    source "$plugin_dir/$script_name"
}

