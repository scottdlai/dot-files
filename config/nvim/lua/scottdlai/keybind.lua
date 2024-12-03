local keymap = vim.keymap

--- Remap Keys ---
-- Insert mode
keymap.set('i', '<C-j>', '<Esc>')

-- Normal, Visual, and Operator-Pending modes
-- Clipboard copy paste
keymap.set({ 'n', 'v', 'o' }, 'gy', '"+y')
keymap.set({ 'n', 'v', 'o' }, 'gp', '"+p')
keymap.set({ 'n', 'v', 'o' }, 'gP', '"+P')
keymap.set({ 'n', 'v', 'o' }, 'B', '^')
keymap.set({ 'n', 'v', 'o' }, 'E', '$')
keymap.set({ 'n', 'v', 'o' }, ';', ':')
-- Have iterm2 / terminal send +/ when hit cmd + /
keymap.set({ 'n', 'v', 'o' }, '+/', '<Plug>NERDCommenterToggle', { silent = true })

-- Normal mode
keymap.set({ 'n' }, '<Left>', ':vertical resize -1<CR>', { silent = true, noremap = true })
keymap.set({ 'n' }, '<Right>', ':vertical resize +1<CR>', { silent = true, noremap = true })
keymap.set({ 'n' }, '<Up>', ':resize +1<CR>', { silent = true, noremap = true })
keymap.set({ 'n' }, '<Down>', ':resize -1<CR>', { silent = true, noremap = true})

keymap.set({ 'n' }, 'H', ':bprevious<CR>')
keymap.set({ 'n' }, 'L', ':bnext<CR>')

-- Keep cursor at the start of line when joining lines
keymap.set('n', 'J', 'mzJ`z')

-- always keep cursor in middle when moving between matches
keymap.set("n", "n", "nzzzv", { noremap = true })
keymap.set("n", "N", "Nzzzv", { noremap = true })

-- Replace all
keymap.set('n', '<C-s>', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Plugin-specific mappings
keymap.set({ 'n' }, '<leader>t', ':NvimTreeFindFile<CR>', { silent = true })
-- vim.keymap.set({ 'n' }, '<C-Space>', ':Buffers<CR>', { silent = true })
keymap.set({ 'n' }, '<C-p>', ':Files<CR>', { silent = true })
keymap.set({ 'n' }, '<C-k>', ':CocFzfList outline<CR>', { silent = true })
keymap.set({ 'n' }, '<C-f>', ':BLines<CR>', { silent = true })

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
keymap.set('x', '//', "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>", { silent = true })

-- from the primeagen: move selected text up and down
keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true })
keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true })

-- send the deleted text to the void register
keymap.set('x', 'p', '"_dP', { noremap = true })

-- leader keybinds
keymap.set({ 'n' }, '<leader>w', ':Bdelete<CR>', { silent = true })
keymap.set({ 'n' }, '<leader>qa', ':bufdo :Bdelete<CR>', { silent = true })
keymap.set({ 'n' }, '<leader>fa', ':FindAllInProject<CR>', { silent = true })
keymap.set({ 'n' }, '<leader>gy', ':Goyo<CR>', { silent = true })
keymap.set({ 'n' }, '<leader>gg', ':vert G<CR>', { silent = true })
