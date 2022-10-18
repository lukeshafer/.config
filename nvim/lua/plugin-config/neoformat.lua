vim.cmd([[
  augroup fmt
    autocmd!
    autocmd BufWritePre * undojoin | Neoformat
  augroup END
]])
--vim.cmd("let g:neoformat_run_all_formatters = 1")
vim.cmd("let g:neoformat_try_node_exe = 1")
vim.cmd("let g:neoformat_enabled_astro = ['prettier']")
