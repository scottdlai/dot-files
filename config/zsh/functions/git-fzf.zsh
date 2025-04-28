function _git_logf {
    git log --color $@ |
    fzf --ansi --wrap +s -0 \
        --prompt 'Commits> ' \
        --header $':: \e[93mCTRL-Y\e[0m to yank commit hash, \e[93mCTRL-S\e[0m to checkout' \
        --delimiter ' ' \
        --accept-nth 1 \
        --preview 'git diff --color {1}^!' \
        --preview-window 'right,50%,<60(down,45%)' \
        --bind 'ctrl-/:toggle-preview' \
        --bind 'ctrl-y:execute-silent(echo -n {1} | pbcopy)+abort' \
        --bind 'ctrl-s:execute-silent(git checkout {1})+abort';
};

function _git_reflogf {
    git reflog --color \
        --format='%C(yellow bold)%h %C(reset)%C(cyan bold)%gD %C(auto)%d %C(reset)%gs %Cgreen(%cr)' $@ |
    fzf --ansi --wrap +s -0 \
        --prompt 'Reflogs> ' \
        --header $':: \e[93mCTRL-Y\e[0m to copy reflog selector, \e[93mCTRL-R\e[0m to reset to reference' \
        --delimiter ' ' \
        --accept-nth 2 \
        --bind 'ctrl-y:execute-silent(echo -n {2} | pbcopy)+abort' \
        --bind 'ctrl-r:execute(git reset {2})+abort';
};

function _git_stash_list_fzf {
    local git_stash='git stash list --pretty="%C(yellow bold)%gd: %C(reset)%gs %C(green)(%cr)" --color=always'

    fzf --ansi \
        --prompt 'Stashes> ' \
        --header $':: \e[93mCTRL-X\e[0m to drop stash, \e[93mCTRL-A\e[0m to apply stash' \
        --delimiter ':' \
        --preview 'git stash show --include-untracked -p --color=always {1}' \
        --preview-window 'right,50%,<60(down,45%)' \
        --bind "start:reload:$git_stash" \
        --bind "ctrl-x:execute-silent(git stash drop {1})+reload:$git_stash" \
        --bind "ctrl-a:execute(git stash apply {1})+abort";
}
