-- Enable line number
vim.g.goyo_linenr = 1
-- Increase width in focus mode
vim.g.goyo_width = 160
vim.g.goyo_height = '90%'

local is_tmux_pane_zoomed = false

vim.api.nvim_create_autocmd('User', {
  pattern = 'GoyoEnter',
  desc = 'Foucs current tmux pane when enter Goyo',
  callback = function(opts)
    local exit_code = os.execute("tmux list-panes -F '\\#F' | grep -q Z") / 256

    is_tmux_pane_zoomed = exit_code == 0

    if not is_tmux_pane_zoomed then
      os.execute('tmux resize-pane -Z')
    end
  end
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'GoyoLeave',
  desc = 'Unfocus current tmux pane when exit Goyo (If pane is not focused before goyo)',
  callback = function(opts)
    if not is_tmux_pane_zoomed then
      os.execute('tmux resize-pane -Z')
    end
  end
})
