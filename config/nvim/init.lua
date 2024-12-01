local Plug = vim.fn['plug#']

vim.call('plug#begin')
Plug('neoclide/coc.nvim', { branch = 'release' })
Plug('nvim-tree/nvim-tree.lua')
Plug('preservim/nerdcommenter')
Plug('junegunn/fzf', { ['do'] = vim.fn['fzf#install'] })
Plug('junegunn/fzf.vim')
Plug 'antoinemadec/coc-fzf'
Plug('sheerun/vim-polyglot')
Plug('tpope/vim-fugitive')
Plug('junegunn/goyo.vim')
Plug('moll/vim-bbye')
Plug('christoomey/vim-tmux-navigator')
-- Themes
Plug('morhetz/gruvbox')
Plug('arcticicestudio/nord-vim')
-- Status bar
Plug 'vim-airline/vim-airline'
vim.call('plug#end')

-- Set leader key before loading plugins
vim.g.mapleader = ','

-- File tree (loading nvim-tree.lua)
require('plugins/nvim-tree')
require('plugins/airline')
require('plugins/coc')
require('plugins/nerd-commeter')

-- personal settings
require('personal')
