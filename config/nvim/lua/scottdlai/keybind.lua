local keymap = vim.keymap

--- Remap Keys ---
-- Insert mode
-- Use backtick as prefix key for tmux
keymap.set('i', '<C-b>', '`', { noremap = true })
keymap.set('o', 'i<C-b>', 'i`', { noremap = true })
keymap.set('o', 'a<C-b>', 'a`', { noremap = true })

-- Normal, Visual, and Operator-Pending modes
-- Clipboard copy paste
keymap.set({ 'n', 'v', 'o' }, 'gy', '"+y', { noremap = true })
keymap.set({ 'n', 'v', 'o' }, 'gp', '"+p', { noremap = true })
keymap.set({ 'n', 'v', 'o' }, 'gP', '"+P', { noremap = true })

keymap.set({ 'n', 'v', 'o' }, 'gb', '^', { noremap = true })
keymap.set({ 'n', 'v', 'o' }, 'ge', '$', { noremap = true })

local charsearch_opts = { silent = true, noremap = true, expr = true }
keymap.set({ 'n', 'v', 'o' }, ';', [[getcharsearch().forward ? ';' : ',']], charsearch_opts)
keymap.set({ 'n', 'v', 'o' }, ',', [[getcharsearch().forward ? ',' : ';']], charsearch_opts)

-- keymap.set({ 'n', 'v', 'o' }, '<CR>', ':', { noremap = true })

-- Normal mode
keymap.set('n', 'g?', ':Helptags<CR>', { noremap = true, silent = true })

-- tab is ctrl-i, map shift tab to ctrl-o
keymap.set('n', '<S-Tab>', '<C-o>', { noremap = true, silent = true })

keymap.set('n', '<Left>', ':vertical resize -1<CR>', { silent = true, noremap = true })
keymap.set('n', '<Right>', ':vertical resize +1<CR>', { silent = true, noremap = true })
keymap.set('n', '<Up>', ':resize +1<CR>', { silent = true, noremap = true })
keymap.set('n', '<Down>', ':resize -1<CR>', { silent = true, noremap = true })

keymap.set('n', 'H', ':bprevious<CR>', { silent = true })
keymap.set('n', 'L', ':bnext<CR>', { silent = true })

-- Keep cursor at the start of line when joining lines
keymap.set('n', 'J', 'mzJ`z:delm z<CR>', { silent = true })

-- Don't add { and } movements to the jumplist
-- https://superuser.com/questions/836784/in-vim-dont-store-motions-in-jumplist
local para_opts = { noremap = true, silent = true }
keymap.set('n', '{', [[:execute "keepjumps norm! " . v:count1 . "{"<CR>]], para_opts)
keymap.set('n', '}', [[:execute "keepjumps norm! " . v:count1 . "}"<CR>]], para_opts)

-- Add <count>j and <count>k to the jumplist
-- https://stackoverflow.com/questions/29746445/is-there-a-vim-command-to-undo-the-last-motion-e-g-countj-or-ctrl-f/29746735#29746735
local jk_opts = { noremap = true, silent = true, expr = true }
keymap.set('n', 'j', [[(v:count > 1 ? "m'" . v:count : '') . 'j']], jk_opts)
keymap.set('n', 'k', [[(v:count > 1 ? "m'" . v:count : '') . 'k']], jk_opts)

-- always keep cursor in middle when moving between matches
keymap.set('n', 'n', 'nzzzv', { noremap = true, silent = true })
keymap.set('n', 'N', 'Nzzzv', { noremap = true, silent = true })

-- Replace word under cursor
keymap.set('n', '<C-s>', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]])
keymap.set('x', '<C-s>', [["0y:%s/<C-r>0/<C-r>0/gci<Left><Left><Left><Left>]])

-- fzf mappings
keymap.set('n', '<C-b>', ':Buffers<CR>', { silent = true })
keymap.set('n', '<C-p>', ':Files<CR>', { silent = true })
keymap.set('n', '<C-k>', ':CocFzfList outline<CR>', { silent = true })
keymap.set('n', '<C-f>', ':BLines<CR>', { silent = true })
keymap.set('n', '<leader>F', ':FindAllInProject<CR>', { silent = true })

-- Integration with Tmux navigation
vim.g.tmux_navigator_no_mappings = 1 -- disable plugin default keybind
keymap.set('n', '<C-w>h', ':TmuxNavigateLeft<CR>', { silent = true })
keymap.set('n', '<C-w>j', ':TmuxNavigateDown<CR>', { silent = true })
keymap.set('n', '<C-w>k', ':TmuxNavigateUp<CR>', { silent = true })
keymap.set('n', '<C-w>l', ':TmuxNavigateRight<CR>', { silent = true })

-- Visual mode
keymap.set('v', 'q', '<Esc>', { noremap = true })

-- from the primeagen: move selected text up and down
keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- leader keybinds
keymap.set('n', '<leader>?', ':Maps<CR>', { silent = true })

keymap.set('n', '<leader>d<Space>', 'mz:%s/\\s\\+$//g<CR>:noh<CR>`z:delm z<CR>', { silent = true, desc = 'Clear trailing whitespace' })

keymap.set('n', '<leader>T', ':NvimTreeFindFile<CR>', { silent = true })

keymap.set('n', '<leader>z', ':Goyo<CR>', { silent = true })

keymap.set('n', '<leader>bd', ':Bdelete<CR>', { silent = true })
keymap.set('n', '<leader>bw', ':Bwipeout<CR>', { silent = true })
keymap.set('n', '<leader>qa', ':bufdo :bwipeout<CR>:clearjumps<CR>', { silent = true })

keymap.set('n', '<leader>G', ':tab G<CR>', { silent = true })
