-- Status bar
-- For some reason the lua version doesn't work
vim.cmd([[
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  let g:airline_symbols.maxlinenr = ''
  let g:airline_symbols.branch = ''
]])

vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline#extensions#tabline#buffer_nr_show"] = 1
