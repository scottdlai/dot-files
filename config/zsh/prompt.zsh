# Git autocomplete
# source: https://github.com/rotsix/dotfiles/blob/master/zsh/.zsh.d/prompt.zsh

[ -z "$EXTRA_PROMPT" ] && EXTRA_PROMPT=(mnml_git)

# Components
function mnml_git {
    local normal='%{\e[1;33m%}'
    local ahead='%{\e[1;32m%}'
    local behind='%{\e[1;31m%}'
    local warning='%{\e[1;33m%}'

    local statcolor="$normal" # assume clean
    local bname="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
    local extra='*'

    if [ -n "$bname" ]; then
        local rs="$(git status --porcelain -b)"
        if $(echo "$rs" | grep -v '^##' &> /dev/null); then # is dirty
            statcolor="$warning"
            extra='~'
        elif $(echo "$rs" | grep '^## .*diverged' &> /dev/null); then # has diverged
            statcolor="$warning"
            extra='^'
        elif $(echo "$rs" | grep '^## .*behind' &> /dev/null); then # is behind
            statcolor="$behind"
            extra='-'
        elif $(echo "$rs" | grep '^## .*ahead' &> /dev/null); then # is ahead
            statcolor="$ahead"
            extra='+'
        fi

        echo -n "%bon $statcolor$bname$extra"
    fi
}

# Wrappers & utils
# join outpus of components
function mnml_wrap {
    local arr=()
    local cmd_out=""
    for cmd in ${(P)1}; do
        cmd_out="$(eval "$cmd")"
        if [ -n "$cmd_out" ]; then
            arr+="$cmd_out"
        fi
    done

    echo -n "${(j: :)arr}"
}

# Setup
setopt prompt_subst

# Prompt
export PROMPT='
%B%{$fg[cyan]%}%n %bin %B%{$fg[blue]%}%~ %bat %B$fg[magenta]%D{%f/%m} %* $(mnml_wrap EXTRA_PROMPT)
%B$fg[cyan]❯ %b'
