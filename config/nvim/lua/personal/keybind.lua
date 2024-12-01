local keymap = vim.keymap

--- Remap Keys ---
-- Insert mode
keymap.set('i', '<C-j>', '<Esc>')

-- Normal, Visual, and Operator-Pending modes
-- Clipboard copy paste
keymap.set({ 'n', 'v', 'o' }, 'gy', '"+y')
keymap.set({ 'n', 'v', 'o' }, 'gp', '"+p')
keymap.set({ 'n', 'v', 'o' }, 'gP', '"+P')
keymap.set({ 'n', 'v', 'o' }, 'K', '{')
keymap.set({ 'n', 'v', 'o' }, 'J', '}')
keymap.set({ 'n', 'v', 'o' }, 'B', '^')
keymap.set({ 'n', 'v', 'o' }, 'E', '$')
keymap.set({ 'n', 'v', 'o' }, ';', ':')
keymap.set({ 'n', 'v', 'o' }, 'gq', ':Bdelete<CR>')
-- Have iterm2 / terminal send +/ when hit cmd + /
keymap.set({ 'n', 'v', 'o' }, '+/', '<Plug>NERDCommenterToggle')

-- Normal mode
keymap.set({ 'n' }, '<Left>', ':vertical resize -1<CR>', { silent = true })
keymap.set({ 'n' }, '<Right>', ':vertical resize +1<CR>', { silent = true })
keymap.set({ 'n' }, '<Up>', ':resize +1<CR>', { silent = true })
keymap.set({ 'n' }, '<Down>', ':resize -1<CR>', { silent = true })
keymap.set({ 'n' }, 'g<Tab>', '>>')
keymap.set({ 'n' }, 'g<S-Tab>', '<<')
keymap.set({ 'n' }, 'H', ':bprevious<CR>')
keymap.set({ 'n' }, 'L', ':bnext<CR>')

-- Plugin-specific mappings
keymap.set({ 'n' }, '<leader>t', ':NvimTreeFindFile<CR>', { silent = true })
-- vim.keymap.set({ 'n' }, '<C-Space>', ':Buffers<CR>', { silent = true })
keymap.set({ 'n' }, '<C-p>', ':Files<CR>', { silent = true })
keymap.set({ 'n' }, '<C-k>', ':CocFzfList outline<CR>', { silent = true })
keymap.set({ 'n' }, '<C-f>', ':BLines<CR>', { silent = true })
keymap.set({ 'n' }, '<leader>f', ':Goyo<CR>', { silent = true })

-- Integration with Tmux navigation
vim.g.tmux_navigator_no_mappings = 1 -- disable plugin default keybind
keymap.set({ 'n' }, '<C-w>h', ':TmuxNavigateLeft<CR>', { silent = true })
keymap.set({ 'n' }, '<C-w>j', ':TmuxNavigateDown<CR>', { silent = true })
keymap.set({ 'n' }, '<C-w>k', ':TmuxNavigateUp<CR>', { silent = true })
keymap.set({ 'n' }, '<C-w>l', ':TmuxNavigateRight<CR>', { silent = true })

-- Visual mode
keymap.set('v', 'q', '<Esc>')
-- Search for visually selected text
-- https://vim.fandom.com/wiki/Search_for_visually_selected_text
keymap.set('v', '//', 'y/\\V<C-R>=escape(@",\'/\\\')<CR><CR>', { silent = true })

keymap.set({ 'v', 'o' }, 'g<Tab>', '>><Esc>')
keymap.set({ 'v', 'o' }, 'g<S-Tab>', '<<<Esc>')

-- send the deleted text to the void register
keymap.set('x', '<leader>p', '"_dP')
keymap.set('x', '<leader>P', '"_dp')
