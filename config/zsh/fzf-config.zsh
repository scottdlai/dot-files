# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Scheme name: Gruvbox dark, medium
# Scheme system: base16
# Scheme author: Dawid Kurek (dawikur@gmail.com), morhetz (https://github.com/morhetz/gruvbox)
# Template author: Tinted Theming (https://github.com/tinted-theming)

_gen_fzf_color_scheme() {
    local color00='#282828'
    local color01='#3c3836'
    local color02='#504945'
    local color03='#665c54'
    local color04='#bdae93'
    local color05='#d5c4a1'
    local color06='#ebdbb2'
    local color07='#fbf1c7'
    local color08='#fb4934'
    local color09='#fe8019'
    local color0A='#fabd2f'
    local color0B='#b8bb26'
    local color0C='#8ec07c'
    local color0D='#83a598'
    local color0E='#d3869b'
    local color0F='#d65d0e'

    local dim='#928374'

    echo "--color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D" \
        "--color=fg:$color04,header:$dim,info:$color0C,pointer:$color0D" \
        "--color=marker:$color0C,fg+:$color06,prompt:$color09,hl+:$color0D"
}

export FZF_DEFAULT_OPTS="$(_gen_fzf_color_scheme) --style full:sharp --layout reverse --tmux center,80% --preview-window 'right,50%,<80(down,40%)'"

export FZF_ALT_C_OPTS="\
    --walker-root $HOME/workspace $HOME/Documents $HOME/Desktop $HOME/Downloads $XDG_CONFIG_HOME \
    --walker-skip .git,node_modules,build,dist,target,Library \
    --bind 'ctrl-/:toggle-preview'
    --preview 'ls -AF --color=always {}'"

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
