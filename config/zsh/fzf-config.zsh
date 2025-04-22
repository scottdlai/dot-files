# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Scheme name: Gruvbox dark, medium
# Scheme system: base16
# Scheme author: Dawid Kurek (dawikur@gmail.com), morhetz (https://github.com/morhetz/gruvbox)
# Template author: Tinted Theming (https://github.com/tinted-theming)

_gen_fzf_color_scheme() {
    echo "--color=bg+:#32302f,border:#928374,spinner:#fabd2f,hl:#b8bb26" \
        "--color=fg:#ebdbb2,header:#928374,info:#8ec07c,pointer:#83a598" \
        "--color=marker:#fabd2f,fg+:#ebdbb2,prompt:#fe8019,hl+:#8ec07c" \
        "--color=label:#bdae93"
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
