--- General Settings ---
local opt = vim.opt
local g = vim.g

-- set undodir
opt.undodir = os.getenv('XDG_STATE_HOME') .. '/vim-undodir/'
opt.undofile = true

-- 5 seconds
opt.timeoutlen = 5000

-- mouse and UI Settings
opt.mouse = 'a'
opt.cmdheight = 2

-- themes
opt.termguicolors = true
opt.background = 'dark'
g.gruvbox_material_foreground = 'material'
g.gruvbox_material_statusline_style = 'material'
g.gruvbox_material_background = 'soft'
g.gruvbox_material_ui_contrast = 'high'
g.gruvbox_material_visual = 'reverse'
g.gruvbox_material_transparent_background = 1
g.gruvbox_material_float_style = 'dim'
vim.cmd('silent! colorscheme gruvbox-material')
-- Status line should show the mode anyways
opt.showmode = false
-- only show 1 status line if there is split
opt.laststatus = 3

-- Line Numbers
opt.number = true
opt.relativenumber = true
opt.colorcolumn = '80'
opt.cursorline = true
opt.signcolumn = "yes:3"

-- Whitespace Settings
opt.wrap = true
opt.textwidth = 80
opt.formatoptions = 'tcqrn1'
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.shiftround = false
opt.listchars = { tab = '| ', lead = '·', trail = '~', }
opt.list = true

opt.foldmethod = 'expr'
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- opt.foldmethod = 'indent'
-- don't fold everything when open
opt.foldlevelstart = 99

-- Always keep at least 12 lines below current cursor
opt.scrolloff = 12

-- Window Management
opt.hidden = true
opt.splitbelow = true
opt.splitright = true

-- Make jumplist behave like a stack
opt.jumpoptions = 'stack'

-- increment alphabets
opt.nrformats:append('alpha')

opt.confirm = true
