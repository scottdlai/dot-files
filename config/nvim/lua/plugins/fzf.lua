-- https://stackoverflow.com/a/62745519
local function rg_ignore_file_name(opts)
  local fzf_vim_grep = vim.fn['fzf#vim#grep']
  local fzf_vim_with_preview = vim.fn["fzf#vim#with_preview"]

  local args = opts.args
  local fzf_opts = fzf_vim_with_preview({ options = '--delimiter : --nth 4..' })
  local command = string.format('rg --column --line-number --no-heading --color=always --smart-case %s', vim.fn.shellescape(args))

  fzf_vim_grep(command, 1, fzf_opts, 0)
end

vim.api.nvim_create_user_command("FindAllInProject", rg_ignore_file_name, {
  bang = true,
  nargs = "*",
})
