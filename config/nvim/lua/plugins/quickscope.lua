-- only highlight on key instead of automatically
vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  desc = 'Better highlighting for quick scope',
  group = vim.api.nvim_create_augroup('quick-scope-color', { clear = true }),
  callback = function()
    vim.api.nvim_set_hl(0, "QuickScopePrimary", { link = "Search" })
    vim.api.nvim_set_hl(0, "QuickScopeSecondary", { link = "Search" })
  end,
})
