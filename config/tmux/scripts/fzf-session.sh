function main {
    local current_session="$(tmux display-message -p '#S')"

    # put current session first
    local list_sessions="echo \"$current_session\"; tmux list-sessions -F '#S' -f '#{!=:#S,'$current_session'}' 2>&1";

    fzf --bind "ctrl-x:execute-silent(tmux kill-session -t {})+reload:$list_sessions" \
        --bind "start:reload:$list_sessions" \
        --bind "focus:transform-preview-label:tmux list-session -F ' #S: #{session_windows} windows ' -f '#{==:#S,{}}'" \
        --bind 'ctrl-/:toggle-preview' \
        --preview 'tmux capture-pane -e -pt {}' \
        --preview-window 'down,80%' \
        --prompt 'switch-client ' \
        --style default \
        --border none \
        --tmux center,100% \
        --header-lines 1 |
        xargs -I '{}' tmux switch-client -t '{}'
}

main $@
