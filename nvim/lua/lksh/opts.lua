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
	-- vim.o.ignorecase = true
  vim.o.wrap = true
  vim.o.linebreak = true
  vim.o.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkon0"

	vim.opt.shortmess:append("I")

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

	vim.api.nvim_create_autocmd("BufReadPost", {
		callback = function()
			if vim.api.nvim_buf_line_count(0) > 10000 then
				vim.wo.foldenable = false
				vim.wo.foldmethod = "manual"
			end
		end,
	})

	vim.o.backupdir = vim.fn.expand("~/.vim/backup")
	vim.o.dir = vim.fn.expand("~/.vim/swapfiles")

	vim.g.mapleader = " "
	vim.g.netrw_liststyle = 3
end

return Opts
