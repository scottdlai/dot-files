-- Enable line number
vim.g.goyo_linenr = 1
-- Increase width in focus mode
vim.g.goyo_width = 120

vim.api.nvim_create_autocmd("User", {
    pattern = 'GoyoEnter',
    desc = "Focus current tmux pane when entering Goyo",
    callback = function()
      os.execute('tmux list-panes -F "\\#F" | grep -q Z || tmux resize-pane -Z')
    end
})

-- vim.api.nvim_create_autocmd("User", {
    -- pattern = 'GoyoLeave',
    -- -- command = "call v:lua.goyo_enter()",
    -- desc = "Unfocus current tmux pane when leaving Goyo",
    -- callback = function()
      -- os.execute('tmux list-panes -F "\\#F" | grep -q Z && tmux resize-pane -Z')
    -- end
-- })
