local keymap = vim.keymap

--- Remap Keys ---
-- Use backtick as prefix key for tmux
keymap.set({ 'i' }, '<C-b>', '`', { noremap = true })

-- Command mode
keymap.set('c', '<C-a>', '<C-b>', { noremap = true })
keymap.set('c', '<C-j>', '<Down>', { noremap = true })
keymap.set('c', '<C-k>', '<Up>', { noremap = true })

-- Normal, Visual, and Operator-Pending modes
-- Clipboard copy paste
keymap.set({ 'n', 'v', 'o' }, 'gy', '"+y', { noremap = true })
keymap.set({ 'n', 'v', 'o' }, 'gp', '"+p', { noremap = true })
keymap.set({ 'n', 'v', 'o' }, 'gP', '"+P', { noremap = true })

local charsearch_opts = { silent = true, noremap = true, expr = true }
keymap.set({ 'n', 'v', 'o' }, ';', [[getcharsearch().forward ? ';' : ',']], charsearch_opts)
keymap.set({ 'n', 'v', 'o' }, ',', [[getcharsearch().forward ? ',' : ';']], charsearch_opts)

-- Normal mode
keymap.set('n', '<F1>', ':Helptags<CR>', { noremap = true, silent = true })
keymap.set('n', '<Leader>1', ':Helptags<CR>', { noremap = true, silent = true })

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

keymap.set('n', 'gJ', ':TSJJoin<CR>', { silent = true })
keymap.set('n', 'gS', ':TSJSplit<CR>', { silent = true })

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
keymap.set('v', '<C-s>', [["0y:%s/<C-r>0/<C-r>0/gci<Left><Left><Left><Left>]])

-- keep selection after indenting
keymap.set('v', '>', '>gv', { noremap = true })
keymap.set('v', '<', '<gv', { noremap = true })

-- fzf mappings
keymap.set('n', '<C-p>', ':Files<CR>', { silent = true })
keymap.set('n', '<C-f>', ':BLines<CR>', { silent = true })
keymap.set('v', '<C-f>', '"0y:BLines <C-r>0<CR>', { silent = true })

keymap.set('n', '<Leader>F', ':Grep<CR>', { silent = true })
keymap.set('v', '<Leader>F', '"0y:Grep <C-r>0<CR>', { silent = true })

-- Integration with Tmux navigation
keymap.set('n', '<C-w>h', ':TmuxNavigateLeft<CR>', { silent = true })
keymap.set('n', '<C-w>j', ':TmuxNavigateDown<CR>', { silent = true })
keymap.set('n', '<C-w>k', ':TmuxNavigateUp<CR>', { silent = true })
keymap.set('n', '<C-w>l', ':TmuxNavigateRight<CR>', { silent = true })

keymap.set('n', '<Leader>B', ':Buffers<CR>', { silent = true, noremap = true })
keymap.set('n', '<Leader>T', ':NvimTreeFindFile<CR>', { silent = true, noremap = true })
keymap.set('n', '<Leader>bw', ':Bwipeout<CR>', { silent = true, noremap = true })
keymap.set('n', '<Leader>Q', ':bufdo bwipeout<CR>', { silent = true, noremap = true })

-- Git stuffs
keymap.set('n', '<Leader>G', ':tab Git<CR>', { silent = true, noremap = true })
keymap.set('n', '<Leader>gb', ':Git blame<CR>', { silent = true, noremap = true })
keymap.set('n', '<Leader>gu', ':GitGutterUndoHunk<CR>', { silent = true, noremap = true })

-- toggle zoom window when splitting
keymap.set('n', '<leader>zz', function()
  local win_amount = #vim.api.nvim_tabpage_list_wins(0)

  if win_amount > 1 then
    vim.cmd('tab split')
    vim.opt.showtabline = 0
  else
    vim.cmd('silent! tabc')
    vim.opt.showtabline = 2
  end
end, { silent = true, noremap = true })
