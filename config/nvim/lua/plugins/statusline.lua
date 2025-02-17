-- Status bar
-- For some reason the lua version doesn't work
vim.cmd([[
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  " let g:airline_symbols.maxlinenr = ''
  let g:airline_symbols.branch = ''
]])

-- disable nerd icons
vim.g.airline_symbols_ascii = 1

vim.g['airline#extensions#tabline#enabled'] = 1

vim.g['airline#extensions#hunks#enabled'] = 0
vim.g['airline#extensions#fzf#enabled'] = 1

-- Simplify the z section to show only maxline:maxcolumn ┃ line:column
vim.g['airline_section_z'] = '%L:%{col("$")-1} ┃ %#__accent_bold#%l:%v%#__restore__#'
