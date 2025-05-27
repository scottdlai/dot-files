-- only highlight on key instead of automatically
vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  desc = 'Better highlighting for quick scope',
  group = vim.api.nvim_create_augroup('quick-scope-color', {}),
  callback = function()
    vim.cmd([[highlight! link QuickScopePrimary Search]])
    vim.cmd([[highlight! link QuickScopeSecondary Search]])
  end,
})
