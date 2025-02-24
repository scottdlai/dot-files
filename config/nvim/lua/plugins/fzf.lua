-- https://stackoverflow.com/a/62745519
local function rg_ignore_file_name(opts)
  local fzf_vim_grep = vim.fn['fzf#vim#grep']
  local fzf_vim_with_preview = vim.fn["fzf#vim#with_preview"]

  local args = opts.args
  local fzf_opts = fzf_vim_with_preview({options = '--prompt "> " --delimiter ":" --nth "4.."'})
  local command = 'rg --hidden --glob "!.git" --column --line-number --no-heading --color=always --smart-case -- ' .. vim.fn["fzf#shellescape"](args)

  fzf_vim_grep(command, fzf_opts, opts.bang)
end

vim.api.nvim_create_user_command("FindAllInProject", rg_ignore_file_name, {
  bang = true,
  nargs = "*",
})

-- Alias Jumps to J
vim.api.nvim_create_user_command('J', 'Jumps', {
  bang = true,
  nargs = "*",
})

-- Alias Marks to M
vim.api.nvim_create_user_command('M', 'Marks', {
  bang = true,
  nargs = "*",
})

if os.getenv('TMUX') then
  vim.g.fzf_layout = { tmux = 'center,60%,60%' }
else
  vim.g.fzf_layout = { window = { width = 0.6, height = 0.6 } }
end
