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
    vim.cmd('setlocal tabstop=2')
    vim.cmd('setlocal shiftwidth=2')

    vim.b.coc_root_patterns = {
      '.git',
      '.env',
      'tailwind.config.js',
      'tailwind.config.ts',
      'tailwind.config.mjs',
      'tailwind.config.cjs',
      'package.json',
    }
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'make', 'gitconfig' },
  desc = 'Files that use tabs',
  group = vim.api.nvim_create_augroup('File that uses tabs', {}),
  callback = function()
    vim.opt.expandtab = false
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'help', 'fugitive', },
  desc = 'Remap q to exit',
  callback = function()
    vim.keymap.set('n', 'q', ':q<CR>', { noremap = true, silent = true, buffer = true })
  end,
})
