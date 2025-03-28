local statusline = {
	" %t",
	"%r",
	"%m",
	"%=",
	"%{&filetype}",
	" %2p%%",
	" %3l:%-2c ",
}

vim.o.statusline = nil
vim.o.statusline = table.concat(statusline, "")
