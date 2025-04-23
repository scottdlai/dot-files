function _git_logf {
    git log --color $@ | \
    fzf --ansi --wrap +s -0 \
        --prompt 'Commits> ' \
        --header $':: \e[93mCTRL-Y\e[0m to yank commit hash' \
        --delimiter ' ' \
        --accept-nth 1 \
        --preview 'git diff --color {1}^!' \
        --bind 'ctrl-/:toggle-preview' \
        --bind 'ctrl-y:execute-silent(echo -n {1} | pbcopy)+abort';
};

function _git_reflogf {
    git reflog --color \
        --format='%C(yellow bold)%h %C(reset)%C(cyan bold)%gD %C(auto)%d %C(reset)%gs %Cgreen(%cr)' $@ | \
    fzf --ansi --wrap +s -0 \
        --prompt 'Reflogs> ' \
        --header $':: \e[93mCTRL-Y\e[0m to copy reflog selector' \
        --delimiter ' ' \
        --accept-nth 2 \
        --bind 'ctrl-y:execute-silent(echo -n {2} | pbcopy)+abort';
};
