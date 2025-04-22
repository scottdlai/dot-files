vim.api.nvim_create_autocmd('VimEnter', {
  pattern = '*',
  group = vim.api.nvim_create_augroup('Empty jumplist on enter', {}),
  desc = 'Start vim with an empty jumplist',
  command = 'clearjumps',
})

--- Filetype-Specific Settings ---
-- Files that use 2 spaces instead of 4
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'json',
    'jsonc',
    'javascript',
    'typescript',
    'typescriptreact',
    'javascriptreact',
    'html',
    'css',
    'lua',
  },
  desc = 'Files that use 2 spaces for indenting',
  group = vim.api.nvim_create_augroup('Files that use 2 spaces for indenting', {}),
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.shiftwidth = 2
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'make', 'gitconfig' },
  desc = 'Files that use tabs',
  group = vim.api.nvim_create_augroup('File that uses tabs', {}),
  callback = function()
    vim.bo.expandtab = false
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'help', 'fugitive', 'fugitiveblame', },
  desc = 'Remap q to exit',
  group = vim.api.nvim_create_augroup('q to exit', {}),
  callback = function()
    vim.keymap.set('n', 'q', ':q<CR>', { noremap = true, silent = true, buffer = true })
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  desc = 'keybinds in diff mode',
  group = vim.api.nvim_create_augroup('diff mode mappings', {}),
  callback = function()
    if vim.opt.diff:get() then
      local opts = { noremap = true, silent = true, buffer = true }
      vim.keymap.set('n', '<LocalLeader>l', ':diffget LOCAL<CR>', opts)
      vim.keymap.set('n', '<LocalLeader>r', ':diffget REMOTE<CR>', opts)
      vim.keymap.set('n', '<LocalLeader>t', ':Windows<CR>', opts)
      vim.keymap.set('n', '<LocalLeader>q', ':tabclose<CR>', opts)
      vim.keymap.set('n', '<LocalLeader>Q', ':qa<CR>', opts)
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.tmux",
  desc = 'treat .tmux files as tmux files',
  group = vim.api.nvim_create_augroup('set filetype tmux', {}),
  callback = function()
    vim.bo.filetype = "tmux"
  end,
})
