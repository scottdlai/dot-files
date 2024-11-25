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

-- Terminal mode
vim.keymap.set('t', '<C-j>', function()
  return vim.bo.filetype == 'fzf' and '<Esc>' or '<C-\\><C-n>'
end, { expr = true })

-- Plugin-specific mappings
vim.keymap.set('n', '<M-Tab>', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '\\', '<Plug>NERDCommenterToggle')
vim.keymap.set('n', '<C-Space>', ':Buffers<CR>')
vim.keymap.set('n', '<C-p>', ':Files<CR>')
vim.keymap.set('n', '<C-f>', ':BLines<CR>')

