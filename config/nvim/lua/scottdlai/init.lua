require('scottdlai/general')
require('scottdlai/keybind')

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
      'lua',
      'html',
      'css',
    },
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

-- Files that use tabs
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'make', 'gitconfig' },
    callback = function()
      vim.opt.expandtab = false
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'tmux',
    callback = function()
      vim.cmd('set formatoptions-=t')
      vim.opt.tw = 0
      vim.opt.wrap = false
    end,
})
