-- https://stackoverflow.com/a/62745519
local function my_rg(opts)
  local fzf_vim_grep = vim.fn['fzf#vim#grep']
  local fzf_vim_with_preview = vim.fn["fzf#vim#with_preview"]
  local fzf_shellescape = vim.fn['fzf#shellescape']

  local args = opts.args
  local header = ':: \x1b[93mCTRL-F\x1b[0m to toggle File, \x1b[93mCTRL-G\x1b[0m to toggle live grep'

  local include_file_name_label = " File name + Text "
  local exclude_file_name_label = " Text "
  local delimiter = ':'

  local rg = 'rg --hidden --glob "!{.git,*.svg}" --column --line-number --no-heading --color=always --smart-case -- '

  local nth = "4.."
  local label = exclude_file_name_label

  local prompt = 'RG> '
  local enabled_flag = '--disabled'
  local start_binding = 'start:rebind(change)+unbind(ctrl-f)'

  -- search file name and all files if query is provided
  if opts.args ~= '' then
    nth = "1.."
    label = include_file_name_label
    prompt = 'FZF> '
    enabled_flag = '--enabled'
    start_binding = 'start:unbind(change)'
  end

  local include_file_name_actions = string.format('change-nth(1..)+change-list-label(%s)', include_file_name_label)
  local exclude_file_name_actions = string.format('change-nth(4..)+change-list-label(%s)', exclude_file_name_label)
  local ctrl_f_bind = string.format([=[ctrl-f:transform:[[ $FZF_NTH = "4.." ]] && echo '%s' || echo '%s']=], include_file_name_actions, exclude_file_name_actions)

  local live_grep_bind = string.format('change:reload(%s {q} 2>&1 || true)', rg)

  local fzf_mode_actions = string.format('unbind(change)+change-prompt(FZF> )+enable-search+clear-query+change-nth(1..)+change-list-label(%s)+rebind(ctrl-f)', include_file_name_label)
  local live_grep_actions = string.format('rebind(change)+change-prompt(RG> )+reload(%s {q} 2>&1 || true)+disable-search+unbind(ctrl-f)', rg)
  local ctrl_g_bind = string.format([=[ctrl-g:transform:[[ "$FZF_PROMPT" =~ "RG" ]] && echo '%s' || echo '%s']=], fzf_mode_actions, live_grep_actions)

  local options = {
    enabled_flag,
    '--prompt', prompt,
    '--header', header,
    '--delimiter', delimiter,
    '--nth', nth,
    '--list-label', label,
    '--bind', ctrl_f_bind,
    '--bind', start_binding,
    '--bind', "focus:transform-preview-label:echo ' {1} '",
    '--bind', live_grep_bind,
    '--bind', ctrl_g_bind,
    '--bind', 'alt-/:toggle-wrap',
  }

  local fzf_opts = fzf_vim_with_preview({options = options})

  -- add || true if no instance is found
  local command = rg .. fzf_shellescape(args) .. ' || true'

  return fzf_vim_grep(command, fzf_opts, opts.bang)
end

vim.api.nvim_create_user_command("Grep", my_rg, {
  bang = true,
  nargs = "*",
})

local function get_files_options()
  local disable_git_label = " All "
  local enable_git_label = " Git "

  local header = ':: \x1b[93mCTRL-G\x1b[0m to toggle Git'

  local rg_enable_git_command = "fd --follow --type file --hidden --exclude '.git' --exclude 'node_modules'"
  local rg_disable_git_command = "fd --follow --type file --hidden --no-ignore --exclude '.git' --exclude 'node_modules'"

  local git_mode_actions = string.format('reload(%s)+change-list-label(%s)', rg_enable_git_command, enable_git_label)
  local all_files_actions = string.format('reload(%s)+change-list-label(%s)', rg_disable_git_command, disable_git_label)

  -- https://github.com/junegunn/fzf/blob/master/ADVANCED.md#toggling-with-a-single-key-binding
  local ctrl_g_bind = string.format('ctrl-g:transform:[[ $FZF_LIST_LABEL =~ "All" ]] && echo "%s" || echo "%s"', git_mode_actions, all_files_actions)

  local start_bind = string.format('start:reload(%s)', rg_enable_git_command)

  local files_options = {
    '--list-label', enable_git_label,
    '--scheme', 'path',
    '--header', header,
    '--bind', ctrl_g_bind,
    '--bind', start_bind,
    '--bind', "focus:transform-preview-label:echo ' {} '"
  }

  return files_options
end

if os.getenv('TMUX') then
  vim.g.fzf_layout = { tmux = 'center,60%,80%' }
else
  vim.g.fzf_layout = { window = { width = 0.6, height = 0.8 } }
end

vim.g.fzf_vim = {
  files_options = get_files_options(),
  windows_options = { '--query', '> ', },
  preview_window = { 'right,50%,<60(down,45%)', 'ctrl-/' },
}

vim.g.fzf_action = {
  ['ctrl-t'] = 'tab split',
  ['ctrl-s'] = 'split',
  ['ctrl-v'] = 'vsplit',
}

-- COC FZF
local function get_coc_fzf_opts()
  return {
    '--layout', 'reverse',
  }
end

vim.g.coc_fzf_preview_toggle_key = vim.g.fzf_vim.preview_window[2]
vim.g.coc_fzf_preview = vim.g.fzf_vim.preview_window[1]
vim.g.coc_fzf_opts = get_coc_fzf_opts()
