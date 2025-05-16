-- https://raw.githubusercontent.com/neoclide/coc.nvim/master/doc/coc-example-config.lua

-- Some servers have issues with backup files, see #649
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 200

local keymap = vim.keymap

-- Autocomplete
function _G.check_back_space()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
keymap.set("i", "<TAB>", [[coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()]], opts)
keymap.set("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keymap.set("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-space> to trigger completion
keymap.set("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keymap.set("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
keymap.set("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })


-- Use Enter to show documentation in preview window
local function show_docs()
  local cw = vim.fn.expand('<cword>')
  if vim.fn.index({'vim', 'help', 'lua'}, vim.bo.filetype) >= 0 then
      vim.api.nvim_command('h ' .. cw)
  elseif vim.api.nvim_eval('coc#rpc#ready()') then
      vim.fn.CocActionAsync('doHover')
  else
      vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
  end
end

keymap.set("n", "K", show_docs, { silent = true, noremap = true })

-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})

-- Setup formatexpr specified filetype(s)
vim.api.nvim_create_autocmd("FileType", {
    group = "CocGroup",
    pattern = "typescript,json",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
})

-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})

-- Apply codeAction to the selected region
-- Example: `<leader>aap` for current paragraph
local opts = {silent = true, nowait = true}
keymap.set({ 'x' }, "<leader>ac", "<Plug>(coc-codeaction-selected)", opts)

-- Remap keys for apply code actions at the cursor position.
keymap.set("n", "<leader>aa", "<Plug>(coc-codeaction-cursor)", opts)
-- Remap keys for apply source code actions for current file.
keymap.set("n", "<leader>af", "<Plug>(coc-codeaction-source)", opts)
-- Apply the most preferred quickfix action on the current line.
keymap.set("n", "<leader>.", "<Plug>(coc-fix-current)", opts)

-- Remap keys for apply refactor code actions.
keymap.set("n", "<leader>rf", "<Plug>(coc-codeaction-refactor)", { silent = true })
keymap.set("x", "<leader>rf", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

-- Run the Code Lens actions on the current line
keymap.set("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)

local opts = { silent = true, noremap = true, expr = true }
keymap.set('n', '<C-d>', [[coc#float#scroll(1)]], opts)
keymap.set('n', '<C-u>', [[coc#float#scroll(0)]], opts)

-- Add `:Format` command to format current buffer
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- Add `:OR` command for organize imports of the current buffer
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Prettier
vim.api.nvim_create_user_command('Prettier', 'call CocAction("runCommand", "prettier.forceFormatDocument")', {})

-- Remove default lsp keymap after nvim 0.11
vim.keymap.del('n', 'grr')
vim.keymap.del('n', 'gri')
vim.keymap.del('n', 'grn')
vim.keymap.del('n', 'gra')
vim.keymap.del('n', 'gO')

-- LSP specific setup
vim.api.nvim_create_autocmd('FileType', {
    pattern = {
      'python',
      'typescript',
      'javascript',
      'typescriptreact',
      'javascriptreact',
      'json',
      'jsonc',
      'html',
      'css',
      'go',
    },
    desc = 'setup keybinds for files with lsp setup',
    group = vim.api.nvim_create_augroup('COC setup', {}),
    callback = function()
      local opts = { silent = true, noremap = true, buffer = true }
      keymap.set('n', '<C-k>', ':CocFzfList outline<CR>', opts)
keymap.set('n', '<Leader>da', ':CocFzfList diagnostics<CR>', { silent = true })

      -- Symbol renaming
      keymap.set("n", "<leader>rn", "<Plug>(coc-rename)", opts)
      keymap.set("n", "<F2>", "<Plug>(coc-rename)", opts)

      -- GoTo code navigation
      keymap.set("n", "gd", "<Plug>(coc-definition)", {silent = true})
      keymap.set("n", "gi", "<Plug>(coc-implementation)", {silent = true})
      keymap.set("n", "gr", "<Plug>(coc-references)", {silent = true})
    end,
})
