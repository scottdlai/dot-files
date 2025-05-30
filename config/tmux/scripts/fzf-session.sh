function main {
    local current_session="$(tmux display-message -p '#S')"
    # filter out current session
    local list_sessions="echo $current_session; tmux list-sessions -F '#S' -f '#{!=:#S,'$current_session'}'";

    fzf --bind "ctrl-x:execute-silent(tmux kill-session -t {})+reload:$list_sessions" \
        --bind "start:reload:$list_sessions" \
        --bind 'ctrl-/:toggle-preview' \
        --preview 'tmux list-windows -F "#{window_index}: #W#F (#{window_panes} panes)" -t {}' \
        --preview-window 'right,50%,<60(down,40%)' \
        --preview-label ' Windows ' \
        --header-lines 1 |
        xargs -I '{}' tmux switch-client -t '{}'
}

main $@
