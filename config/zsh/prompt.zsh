# Git autocomplete
# source: https://github.com/rotsix/dotfiles/blob/master/zsh/.zsh.d/prompt.zsh

[ -z "$EXTRA_PROMPT" ] && EXTRA_PROMPT=(mnml_git)

# Components
function mnml_git {
    local normal='%F{white}%B'
    local ahead='%F{green}%B'
    local behind='%F{red}%B'
    local warning='%F{yellow}%B'

    local bname="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
    # assume clean
    local statcolor="$normal"
    local extra='*'

    if [ -n "$bname" ]; then
        local rs="$(git status --porcelain -b)"
        if $(echo "$rs" | grep -v '^##' &> /dev/null); then
            # is dirty
            statcolor="$warning"
            extra='~'
        elif $(echo "$rs" | grep '^## .*diverged' &> /dev/null); then
            # has diverged
            statcolor="$warning"
            extra='^'
        elif $(echo "$rs" | grep '^## .*behind' &> /dev/null); then
            # is behind
            statcolor="$behind"
            extra='-'
        elif $(echo "$rs" | grep '^## .*ahead' &> /dev/null); then
            # is ahead
            statcolor="$ahead"
            extra='+'
        fi

        echo -n "on $statcolor$bname$extra"
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
%B%F{cyan}%n%f%b in %B%F{blue}%~%f%b at %B%F{magenta}%D{%f/%m} %*%f%b $(mnml_wrap EXTRA_PROMPT)
%B%F{cyan}❯ %b'
