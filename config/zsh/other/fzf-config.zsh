# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

_gen_fzf_color_scheme() {
    echo "--color=bg+:#3c3836,border:#928374,spinner:#d8a657,hl:#a9b665,fg:#d4be98,header:#928374,info:#89b482,pointer:#7daea3,marker:#d8a657,fg+:#d4be98,prompt:#e78a4e,hl+:#89b482,label:white"
}

export FZF_DEFAULT_OPTS="$(_gen_fzf_color_scheme) --style full:sharp \
    --layout reverse \
    --height 80% \
    --tmux center,60%,80% \
    --preview-label ' Preview '"

export FZF_ALT_C_OPTS="\
    --walker-root $HOME/workspace $HOME/Documents $HOME/Desktop $HOME/Downloads $XDG_CONFIG_HOME \
    --walker-skip .git,node_modules,build,dist,target,Library \
    --bind 'ctrl-/:toggle-preview' \
    --preview 'ls -AF --color=always {}' \
    --preview-window 'right,50%,<60(down,40%)'"

export FZF_CTRL_T_OPTS="\
    --walker-skip .git,node_modules,build,target,dist \
    --preview 'fzf-preview.sh {}' \
    --bind 'ctrl-/:toggle-preview'"

export FZF_CTRL_R_OPTS="\
    --wrap \
    --info inline \
    --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' \
    --header ':: Press \x1b[93mCTRL-Y\x1b[0m to copy command into clipboard'"

# Map Ctrl-p to launch fzf cd widget
bindkey '^p' fzf-cd-widget
