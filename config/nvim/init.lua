local Plug = vim.fn['plug#']

vim.call('plug#begin')
-- intellisense and auto-complete
Plug('neoclide/coc.nvim', { branch = 'release' })
Plug('antoinemadec/coc-fzf')

Plug('nvim-tree/nvim-tree.lua')

-- fzf
Plug('junegunn/fzf', { ['do'] = vim.fn['fzf#install'] })
Plug('junegunn/fzf.vim')

-- syntax stuffs
Plug('sheerun/vim-polyglot')
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug('nvim-treesitter/nvim-treesitter-textobjects')

-- utilities
Plug('tpope/vim-fugitive')
Plug('airblade/vim-gitgutter')
Plug('junegunn/goyo.vim')
Plug('echasnovski/mini.surround')
-- quit buffer without removing splits
Plug('moll/vim-bbye')
Plug('christoomey/vim-tmux-navigator')

-- themes
-- this one supports treesitter
Plug('sainnhe/gruvbox-material')

-- status bar
Plug('vim-airline/vim-airline')
vim.call('plug#end')

-- set leader key before loading plugins
vim.g.mapleader = ' '

-- plugins
require('plugins')

-- personal settings
require('scottdlai')
