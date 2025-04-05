-- https://stackoverflow.com/a/62745519
local function rg_ignore_file_name(opts)
  local fzf_vim_grep = vim.fn['fzf#vim#grep']
  local fzf_vim_with_preview = vim.fn["fzf#vim#with_preview"]

  local args = opts.args
  local prompt = 'Rg> '
  local header = ':: \x1b[93mCTRL-F\x1b[0m to toggle File name search, \x1b[93mCTRL-R\x1b[0m to re-trigger rg'

  local include_file_name_label = " File name + Text "
  local exclude_file_name_label = " Text "
  local delimiter = ':'

  local current_file = vim.fn.expand('%:.')

  local rg = 'rg --hidden --glob "!.git" --column --line-number --no-heading --with-filename --color=always --smart-case -- '

  local nth = "4.."
  local label = exclude_file_name_label
  local search_scope = current_file

  -- search file name and all files if query is provided
  if opts.args ~= '' then
    nth = "1.."
    label = include_file_name_label
    search_scope = '.'
  end

  local ctrl_f_bind = string.format('ctrl-f:transform-nth([[ $FZF_NTH = "4.." ]] && echo "1.." || echo "4..")+transform-border-label([[ $FZF_NTH = "4.." ]] && echo "%s" || echo "%s")', exclude_file_name_label, include_file_name_label)

  local ctrl_r_bind = string.format('ctrl-r:reload(%s {q})+change-nth(1..)+change-border-label(%s)', rg, include_file_name_label)

  local options = {
    '--prompt', prompt,
    '--header', header,
    '--delimiter', delimiter,
    '--nth', nth,
    '--wrap',
    '--border-label', label,
    '--bind', ctrl_f_bind,
    '--bind', ctrl_r_bind,
    -- clear query after reload rg
    '--bind', 'load:clear-query',
  }

  local fzf_opts = fzf_vim_with_preview({options = options})

  local command = rg .. vim.fn["fzf#shellescape"](args) .. ' ' .. search_scope

  fzf_vim_grep(command, fzf_opts, opts.bang)
end

local function get_files_options()
  local disable_git_label = " All "
  local enable_git_label = " Git "

  local header = ':: \x1b[93mCTRL-G\x1b[0m to toggle Git'

  -- hacky way to include .env files in result if ignored by git
  local rg_enable_git_command = "rg --files --glob '.env*'; rg --files --hidden --glob '!.git/' --glob '!.env*'"
  local rg_disable_git_command = "rg --files --hidden --no-ignore --glob '!{.git,node_modules}/' | sort"

  -- https://github.com/junegunn/fzf/blob/master/ADVANCED.md#toggling-with-a-single-key-binding
  local ctrl_g_bind = string.format('ctrl-g:transform:[[ $FZF_BORDER_LABEL =~ "All" ]] && echo "reload(%s)+change-border-label(%s)" || echo "reload(%s)+change-border-label(%s)"', rg_enable_git_command, enable_git_label, rg_disable_git_command, disable_git_label)

  local start_bind = string.format('start:reload(%s)', rg_enable_git_command)

  local files_options = {
    '--border-label', enable_git_label,
    '--scheme', 'path',
    '--filepath-word',
    '--header', header,
    '--bind', ctrl_g_bind,
    '--bind', start_bind,
    '--bind', 'ctrl-w:backward-kill-word',
  }

  return files_options
end

vim.api.nvim_create_user_command("Rg", rg_ignore_file_name, {
    bang = true,
    nargs = "*",
  })

if os.getenv('TMUX') then
  vim.g.fzf_layout = { tmux = 'center,80%,80%' }
else
  vim.g.fzf_layout = { window = { width = 0.8, height = 0.8 } }
end

local function get_coc_fzf_opts()
  local query_top = 'echo \'change-query(!^| )+change-border-label( Top )\''
  local query_functions = 'echo "change-query([Function] | [Method] | [Constructor] )+change-border-label( Function )"'
  local query_classes = 'echo "change-query([Class] | [Interface] | [Property] )+change-border-label( Class )"'
  local query_all = 'echo "clear-query+change-border-label( All )"'

  local toggle_symbols_bind = string.format([=[ctrl-g:transform:if [[ "$FZF_BORDER_LABEL" =~ "All" ]]; then %s; elif [[ "$FZF_BORDER_LABEL" =~ "Top" ]]; then %s; elif [[ "$FZF_BORDER_LABEL" =~ "Function" ]]; then %s; else %s; fi]=], query_top, query_functions, query_classes, query_all)

  return {
    '--layout', 'reverse',
    '--border-label', ' All ',
    '--header', ':: \x1b[93mCTRL-G\x1b[0m to toggle between symbols',
    -- don't sort the result to preserve outline
    '--no-sort',
    '--bind', toggle_symbols_bind,
    '--bind', 'start:transform:[[ ! "$FZF_PROMPT" =~ "Outline" ]] && echo "change-header()+change-border-label()+clear-query+toggle-sort+unbind(ctrl-g)"',
  }
end

vim.g.fzf_vim = {
  files_options = get_files_options(),
  windows_options = { '--query', '> ', },
  buffers_jump = 1,
  preview_window = { 'right,50%,<80(down,40%)', 'ctrl-/' },
}

-- COC FZF
vim.g.coc_fzf_preview_toggle_key = 'ctrl-/'
vim.g.coc_fzf_preview = vim.g.fzf_vim.preview_window[1]
vim.g.coc_fzf_opts = get_coc_fzf_opts()
