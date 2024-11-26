--- Remap Keys ---
-- Insert mode
vim.keymap.set('i', '<C-j>', '<Esc>')

-- Normal, Visual, and Operator-Pending modes
vim.keymap.set({ 'n', 'v', 'o' }, 'gy', '"+y')
vim.keymap.set({ 'n', 'v', 'o' }, 'gp', '"+p')
vim.keymap.set({ 'n', 'v', 'o' }, 'K', '{')
vim.keymap.set({ 'n', 'v', 'o' }, 'J', '}')
vim.keymap.set({ 'n', 'v', 'o' }, 'B', '^')
vim.keymap.set({ 'n', 'v', 'o' }, 'E', '$')
vim.keymap.set({ 'n', 'v', 'o' }, ';', ':')
vim.keymap.set({ 'n', 'v', 'o' }, 'gq', ':Bdelete<CR>')

-- Normal mode
vim.keymap.set('n', '<Left>', ':vertical resize -1<CR>')
vim.keymap.set('n', '<Right>', ':vertical resize +1<CR>')
vim.keymap.set('n', '<Up>', ':resize +1<CR>')
vim.keymap.set('n', '<Down>', ':resize -1<CR>')
vim.keymap.set('n', 'g<Tab>', '>>_')
vim.keymap.set('n', 'g<S-Tab>', '<<_')

-- Integration with Tmux navigation
vim.keymap.set('n', '<C-w>h', ':TmuxNavigateLeft<CR>', { silent = true })
vim.keymap.set('n', '<C-w>j', ':TmuxNavigateDown<CR>', { silent = true })
vim.keymap.set('n', '<C-w>k', ':TmuxNavigateUp<CR>', { silent = true })
vim.keymap.set('n', '<C-w>l', ':TmuxNavigateRight<CR>', { silent = true })

-- Visual mode
vim.keymap.set('v', 'q', '<Esc>')
-- Search for visually selected text
-- https://vim.fandom.com/wiki/Search_for_visually_selected_text
vim.keymap.set('v', '//', 'y/\\V<C-R>=escape(@",\'/\\\')<CR><CR>', { silent = true })

-- Plugin-specific mappings
vim.keymap.set('n', '<M-Tab>', ':NvimTreeFocus<CR>')
vim.keymap.set('n', '\\', '<Plug>NERDCommenterToggle')
vim.keymap.set('n', '<C-Space>', ':Buffers<CR>')
vim.keymap.set('n', '<C-p>', ':Files<CR>')
vim.keymap.set('n', '<C-f>', ':BLines<CR>')

--- General Settings ---

-- set undodir
vim.opt.undodir = os.getenv('XDG_STATE_HOME') .. '/vim-undodir/'
vim.opt.undofile = true

-- Mouse and UI Settings
vim.opt.mouse = 'a'
vim.opt.cmdheight = 2
vim.cmd('highlight Comment cterm=italic gui=italic')

-- themes
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.g.gruvbox_contrast_dark = 'medium'
vim.cmd('silent! colorscheme gruvbox')
vim.opt.showmode = false

-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Whitespace Settings
vim.opt.wrap = false
vim.opt.textwidth = 80
vim.opt.formatoptions = 'tcqrn1'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftround = false
vim.opt.colorcolumn = '80'
vim.opt.cursorline = true
vim.opt.listchars = { tab = '| ', trail = '~' }
vim.opt.list = true

-- Window Management
vim.opt.hidden = true
vim.opt.splitbelow = true
vim.opt.splitright = true

--- Filetype-Specific Settings ---
-- Files that use 2 spaces instead of 4
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'ocaml', 'json', 'javascript', 'typescript', 'lua' },
    callback = function()
      vim.cmd('set tabstop=2')
      vim.cmd('set shiftwidth=2')
    end,
})

-- Files that use tabs
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'make', 'gitconfig' },
    callback = function()
      vim.cmd('set noexpandtab')
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'tmux',
    callback = function()
      vim.cmd('set formatoptions-=t')
      vim.cmd('set tw=0')
      vim.cmd('set nowrap')
    end,
})
