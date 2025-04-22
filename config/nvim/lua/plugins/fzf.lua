-- https://stackoverflow.com/a/62745519
local function my_rg(opts)
  local fzf_vim_grep = vim.fn['fzf#vim#grep']
  local fzf_vim_with_preview = vim.fn["fzf#vim#with_preview"]
  local fzf_shellescape = vim.fn['fzf#shellescape']

  local args = opts.args
  local header = ':: \x1b[93mCTRL-F\x1b[0m to toggle File, \x1b[93mCTRL-G\x1b[0m to live grep'

  local include_file_name_label = " File name + Text "
  local exclude_file_name_label = " Text "
  local delimiter = ':'

  local rg = 'rg --hidden --glob "!{.git,*.svg}" --column --line-number --no-heading --color=always --smart-case -- '

  local nth = "4.."
  local label = exclude_file_name_label

  -- search file name and all files if query is provided
  if opts.args ~= '' then
    nth = "1.."
    label = include_file_name_label
  end

  local ctrl_f_bind = string.format('ctrl-f:transform-nth([[ $FZF_NTH = "4.." ]] && echo "1.." || echo "4..")+transform-list-label([[ $FZF_NTH = "4.." ]] && echo "%s" || echo "%s")', exclude_file_name_label, include_file_name_label)

  local live_grep_bind = string.format('change:reload(%s {q} 2>&1 || true)', rg)

  local ctrl_g_bind = string.format([=[ctrl-g:transform:[[ "$FZF_PROMPT" =~ "RG" ]] && echo 'unbind(change)+change-prompt(FZF> )+enable-search+clear-query' || echo 'rebind(change)+change-prompt(RG> )+reload(%s {q} 2>&1 || true)+disable-search']=], rg)

  local options = {
    '--prompt', 'FZF> ',
    '--header', header,
    '--delimiter', delimiter,
    '--nth', nth,
    '--wrap',
    '--list-label', label,
    '--bind', ctrl_f_bind,
    '--bind', 'start:unbind(change)',
    '--bind', "focus:transform-preview-label:echo ' {1} '",
    '--bind', live_grep_bind,
    '--bind', ctrl_g_bind,
    '--bind', 'alt-a:toggle-all',
  }

  local fzf_opts = fzf_vim_with_preview({options = options})

  -- add || true if no instance is found
  local command = rg .. fzf_shellescape(args) .. ' || true'

  fzf_vim_grep(command, fzf_opts, opts.bang)
end

local function get_files_options()
  local disable_git_label = " All "
  local enable_git_label = " Git "

  local header = ':: \x1b[93mCTRL-G\x1b[0m to toggle Git'

  -- hacky way to include .env files in result if ignored by git
  local rg_enable_git_command = "fd --follow --type file --hidden --exclude '.git' --exclude 'node_modules'"
  local rg_disable_git_command = "fd --follow --type file --hidden --no-ignore --exclude '.git' --exclude 'node_modules'"

  -- https://github.com/junegunn/fzf/blob/master/ADVANCED.md#toggling-with-a-single-key-binding
  local ctrl_g_bind = string.format('ctrl-g:transform:[[ $FZF_LIST_LABEL =~ "All" ]] && echo "reload(%s)+change-list-label(%s)" || echo "reload(%s)+change-list-label(%s)"', rg_enable_git_command, enable_git_label, rg_disable_git_command, disable_git_label)

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

vim.api.nvim_create_user_command("Rg", my_rg, {
  bang = true,
  nargs = "*",
})

if os.getenv('TMUX') then
  vim.g.fzf_layout = { tmux = 'center,60%,80%' }
else
  vim.g.fzf_layout = { window = { width = 0.6, height = 0.8 } }
end

vim.g.fzf_vim = {
  files_options = get_files_options(),
  windows_options = { '--query', '> ', },
  buffers_jump = 1,
  preview_window = { 'right,50%,<60(down,45%)', 'ctrl-/' },
}

-- COC FZF
local function get_coc_fzf_opts()
  local query_top = 'echo \'change-query(!^| )+change-list-label( Top )\''
  local query_functions = 'echo "change-query([Function] | [Method] | [Constructor] )+change-list-label( Function )"'
  local query_classes = 'echo "change-query([Class] | [Interface] | [Property] )+change-list-label( Class )"'
  local query_all = 'echo "clear-query+change-list-label( All )"'

  local toggle_symbols_bind = string.format([=[ctrl-g:transform:if [[ "$FZF_LIST_LABEL" =~ "All" ]]; then %s; elif [[ "$FZF_LIST_LABEL" =~ "Top" ]]; then %s; elif [[ "$FZF_LIST_LABEL" =~ "Function" ]]; then %s; else %s; fi]=], query_top, query_functions, query_classes, query_all)

  return {
    '--layout', 'reverse',
    '--list-label', ' All ',
    '--header', ':: \x1b[93mCTRL-G\x1b[0m to toggle between symbols',
    -- don't sort the result to preserve outline
    '--no-sort',
    '--bind', toggle_symbols_bind,
    '--bind', 'start:transform:[[ ! "$FZF_PROMPT" =~ "Outline" ]] && echo "change-header()+change-list-label()+clear-query+toggle-sort+unbind(ctrl-g)"',
  }
end

vim.g.coc_fzf_preview_toggle_key = vim.g.fzf_vim.preview_window[2]
vim.g.coc_fzf_preview = vim.g.fzf_vim.preview_window[1]
vim.g.coc_fzf_opts = get_coc_fzf_opts()
