local Plug = vim.fn['plug#']

vim.call('plug#begin')
Plug('nvim-tree/nvim-tree.lua')
Plug('jiangmiao/auto-pairs')
Plug('preservim/nerdcommenter')
Plug('junegunn/fzf', { ['do'] = vim.fn['fzf#install'] })
Plug('junegunn/fzf.vim')
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

-- File tree (loading nvim-tree.lua)
require('plugins-settings')

-- personal settings
require('personal')
