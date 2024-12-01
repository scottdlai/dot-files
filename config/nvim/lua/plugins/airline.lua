-- Status bar
-- For some reason the lua version doesn't work
vim.cmd([[
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  " let g:airline_symbols.maxlinenr = ''
  " let g:airline_symbols.branch = ''
]])

-- disable nerd icons
vim.g.airline_symbols_ascii = 1

vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#tabline#buffer_nr_show'] = 1

-- Simplify the z section to show only maxline:maxcolumn ≡ [line:column]
vim.g['airline_section_z'] = '%#__accent_bold#%L:%{col("$")-1} ≡ [%l:%v]%#__restore__#'
