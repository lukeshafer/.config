if vim.g.vscode then
	require("lksh.vsc-config")
	return
end

-- Editor Settings
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.termguicolors = true
vim.o.expandtab = true
vim.o.background = "dark" -- sets light/dark for some colorschemes
vim.o.number = true
vim.o.numberwidth = 2
vim.o.mouse = "a"
vim.o.cursorline = true
vim.o.showtabline = 2
vim.o.splitright = true
vim.opt.diffopt:append({ "iwhiteall" })
vim.opt.shortmess:append("I")

local utils = require("lksh.utils")
if utils.IS_WINDOWS then
	vim.o.backupdir = utils.HOME_DIR .. "\\.vim\\backup"
	vim.o.dir = utils.HOME_DIR .. "\\.vim\\swapfiles"
else
	vim.o.backupdir = utils.HOME_DIR .. "/.vim/backup"
	vim.o.dir = utils.HOME_DIR .. "/.vim/swapfiles"
end

vim.g.mapleader = " "

require("lksh.keymaps").init()
require("lksh.commands").init()
require("lksh.plugins").init()
require("lksh.lsp").init()
require("lksh.statusline").init()
require("lksh.treesitter").init()
require("lksh.tabline").init()
