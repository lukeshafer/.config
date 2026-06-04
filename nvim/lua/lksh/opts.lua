local Opts = {}

function Opts.init()
	-- Editor Settings
	vim.o.tabstop = 2
	vim.o.shiftwidth = 2
	vim.o.expandtab = true
	vim.o.background = "dark" -- sets light/dark for some colorschemes
	vim.o.number = true
	-- vim.o.numberwidth = 2
	vim.o.mouse = "a"
	vim.o.cursorline = true
	-- vim.o.showtabline = 2
	vim.o.splitright = true
	vim.opt.diffopt:append({ "iwhiteall" })
	vim.o.ignorecase = true

	vim.o.smoothscroll = true

	-- vim.o.statuscolumn = "%s%C%l"

	vim.o.foldenable = true
	vim.o.foldcolumn = "auto:1"
	vim.o.foldmethod = "indent"
	vim.o.foldlevelstart = 1
	-- vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
	vim.o.foldtext = ""
	vim.opt.fillchars = {
		foldopen = "󰅀",
		foldclose = "󰅂",
		foldinner = " ",
	}

	vim.o.backupdir = vim.fn.expand("~/.vim/backup")
	vim.o.dir = vim.fn.expand("~/.vim/swapfiles")

	vim.g.mapleader = " "
	vim.g.netrw_liststyle = 3
end

return Opts
