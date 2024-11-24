" Insert mode
inoremap <C-j> <Esc>

" normal, visual and operator pending mode
noremap gy "+y
noremap gp "+p
noremap K {
noremap J }
noremap B ^
noremap E $
noremap ; :
noremap g; ``
noremap gq :bd<CR>

" normal mode
nmap <Left> :vertical resize -2<CR>
nmap <Right> :vertical resize +2<CR>
nmap <Up> :resize +2<CR>
nmap <Down> :resize -2<CR>
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-w> <C-w>w

" visual mode
vnoremap q <Esc>

" Terminal mode
tnoremap <expr> <C-j> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"

