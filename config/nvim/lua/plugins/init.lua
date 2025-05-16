require('plugins/nvim-tree')
require('plugins/statusline')
require('plugins/coc')
require('plugins/fzf')
require('plugins/goyo')
require('plugins/treesitter')
require('plugins/surround')

require('treesj').setup()

vim.g.tmux_navigator_no_mappings = 1 -- disable plugin default keybind
-- disable navigating to another tmux pane when zoomed
vim.g.tmux_navigator_disable_when_zoomed = 1
vim.g.gitgutter_map_keys = 0

-- only highlight on key instead of automatically
vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
