--- General Settings ---
local opt = vim.opt
local g = vim.g

-- set undodir
opt.undodir = os.getenv('XDG_STATE_HOME') .. '/vim-undodir/'
opt.undofile = true

opt.timeoutlen = 5000

-- Mouse and UI Settings
opt.mouse = 'a'
opt.cmdheight = 2
vim.cmd('highlight Comment cterm=italic gui=italic')

-- themes
opt.termguicolors = true
opt.background = 'dark'
g.gruvbox_contrast_dark = 'medium'
vim.cmd('silent! colorscheme gruvbox')
-- Status line should show the mode anyways
opt.showmode = false

-- Line Numbers
opt.number = true
opt.relativenumber = true
opt.colorcolumn = '80'
opt.cursorline = true

-- Whitespace Settings
opt.wrap = false
opt.textwidth = 80
opt.formatoptions = 'tcqrn1'
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.shiftround = false
opt.listchars = { tab = '| ', trail = '~' }
opt.list = true

opt.foldmethod = 'indent'
-- don't fold everything when open
opt.foldlevelstart = 99

-- Always keep at least 12 lines below current cursor
opt.scrolloff = 12

-- Window Management
opt.hidden = true
opt.splitbelow = true
opt.splitright = true
