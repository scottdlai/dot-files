local Plug = vim.fn['plug#']

vim.call('plug#begin')
Plug('neoclide/coc.nvim', { branch = 'release' })
Plug('nvim-tree/nvim-tree.lua')
Plug('preservim/nerdcommenter')
Plug('junegunn/fzf', { ['do'] = vim.fn['fzf#install'] })
Plug('junegunn/fzf.vim')
Plug('antoinemadec/coc-fzf')
Plug('sheerun/vim-polyglot')
Plug('tpope/vim-fugitive')
Plug('junegunn/goyo.vim')
-- Quit buffer without removing splits
Plug('moll/vim-bbye')
Plug('christoomey/vim-tmux-navigator')
-- Themes
Plug('morhetz/gruvbox')
-- Status bar
Plug 'vim-airline/vim-airline'
vim.call('plug#end')

-- Set leader key before loading plugins
vim.g.mapleader = ','

-- plugins
require('plugins')

-- personal settings
require('scottdlai')
