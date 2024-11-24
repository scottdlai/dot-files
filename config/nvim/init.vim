" Plugins
call plug#begin()
" Utilities
Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/goyo.vim'
" Themes
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'
" Status bar
Plug 'vim-airline/vim-airline'
call plug#end()

set undodir=$XDG_STATE_HOME/vim-undodir/
set undofile

" Enables syntax highlighting
filetype plugin indent on
syntax on

" Themes and settings for status bar
set noshowmode
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = ''
let g:airline#extensions#tabline#enabled=1

" Themes for editor
set termguicolors
set bg=dark
let g:gruvbox_contrast_dark='medium'
colorscheme gruvbox

" Whitespace setting
set nowrap
set textwidth=80
set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround
set colorcolumn=80
set cursorline
" Show trailing white space
set listchars=tab:\|\ ,trail:~
set list
" Show line number
set number relativenumber
" Mouse support
set mouse=a
" Set the height of the command window.
set cmdheight=2
" Italicize comments
highlight Comment cterm=italic gui=italic
" Adds space to the left of comments
let g:NERDSpaceDelims = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Close NERDTree when open a file
let NERDTreeQuitOnOpen=1

" Other
set hidden
set splitbelow splitright
au TermOpen * setlocal nonumber norelativenumber

" File that use 2 spaces for tab
autocmd FileType ocaml,json,javascript,typescript set tabstop=2|set shiftwidth=2

" File that use tabs instead of spaces
autocmd FileType make,gitconfig set noexpandtab

autocmd FileType tmux set formatoptions-=t | set tw=0 | set nowrap

" toggle terminal
source $XDG_CONFIG_HOME/nvim/toggle_terminal.vim

" remap keys
source $XDG_CONFIG_HOME/nvim/remap_key.vim

" Coc configuration
" source $XDG_CONFIG_HOME/.config/nvim/coc-config.vim

" Remap keys for plugins
let g:AutoPairsShortcutToggle = ''
map <M-Tab> :NERDTreeToggle<CR>
map \\ <plug>NERDCommenterToggle
nmap <C-Space> :Buffers<CR>
nmap <C-p> :Files<CR>
nmap <C-f> :BLines<CR>
