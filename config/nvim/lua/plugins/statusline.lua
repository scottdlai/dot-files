-- Status bar
-- For some reason the lua version doesn't work
vim.cmd([[
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  " let g:airline_symbols.maxlinenr = ''
  let g:airline_symbols.branch = 'λ'
]])

-- disable nerd icons
vim.g.airline_symbols_ascii = 1

vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#tabline#formatter'] = 'short_path_improved'
vim.g['airline#extensions#tabline#show_close_button'] = 0
vim.g['airline#extensions#tabline#tabs_label'] = ''
vim.g['airline#extensions#tabline#buffers_label'] = ''
vim.g['airline_section_c_only_filename'] = 1

vim.g['airline#extensions#hunks#enabled'] = 0
-- disable coc status (like Prettier)
vim.g['airline#extensions#coc#show_coc_status'] = 0

-- show filetype | encoding | fileformat
--vim.g.airline_section_x = "%{&fileformat} | %{&encoding} | " .. "%{len(&filetype) > 0 ? &filetype : 'no ft'}"
vim.g.airline_section_x = '%{strpart(&fileformat." | ".&encoding." | ".(len(&filetype) > 0 ? &filetype : "no ft"), 0, 25)}'
vim.g.airline_section_y = '%p%%'
-- just show line:column
vim.g.airline_section_z = ' %#__accent_bold#%l:%v%#__restore__# '
