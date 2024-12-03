# source: https://github.com/rotsix/dotfiles/blob/master/zsh/.zsh.d/prompt.zsh
# Global settings
AHEAD="${AHEAD:-2}"
BEHIND="${BEHIND:-1}"
WARNING="${WARNING:-3}"
NORMAL="${NORMAL:-15}"

[ -z "$MNML_RPROMPT" ] && MNML_RPROMPT=(mnml_git)

# Components
function mnml_git {
  local statc="%{\e[0;3${NORMAL}m%}" # assume clean
  local bname="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"

  if [ -n "$bname" ]; then
      local rs="$(git status --porcelain -b)"
      if $(echo "$rs" | grep -v '^##' &> /dev/null); then # is dirty
          statc="%{\e[0;3${WARNING}m%}"
      elif $(echo "$rs" | grep '^## .*diverged' &> /dev/null); then # has diverged
          statc="%{\e[0;3${WARNING}m%}"
      elif $(echo "$rs" | grep '^## .*behind' &> /dev/null); then # is behind
          statc="%{\e[0;3${BEHIND}m%}"
      elif $(echo "$rs" | grep '^## .*ahead' &> /dev/null); then # is ahead
          statc="%{\e[0;3${AHEAD}m%}"
      else # is clean
          statc="%{\e[0;3${NORMAL}m%}"
      fi

      echo -n "$statc %\[$bname%\]%{\e[0m%}"
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

# Prompt
export PS1="
%B%{$fg[cyan]%}┌[%{$fg[yellow]%}%n%{$fg[cyan]%}]%{$fg[cyan]%}─%{$fg[cyan]%}[%{$fg[blue]%}%~%{$fg[cyan]%}]
└─❯ %b"

# https://stackoverflow.com/questions/36343731/zsh-having-right-prompt-on-same-level-as-left-using-prezto
local _lineup=$'\e[1A'
local _linedown=$'\e[1B'
export RPROMPT="%{${_lineup}%}$(mnml_wrap MNML_RPROMPT)%{${_linedown}%}"

# export PS1="
# %B┌[%{$fg[yellow]%}%n%{$reset_color%}]─[%{$fg[blue]%}%~%{$reset_color%}]
# └─❯ %b"
