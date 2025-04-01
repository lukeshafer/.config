local IS_WINDOWS = vim.uv.os_uname().sysname == "Windows_NT"
HOME = os.getenv("HOME")
if not HOME then
	HOME = os.getenv("USERPROFILE")
	IS_WINDOWS = true
end

-- Required for NvimTree
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- Editor Settings
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.termguicolors = true
vim.o.expandtab = true
vim.o.background = "dark" -- sets light/dark for some colorschemes
vim.o.number = true
vim.o.numberwidth = 2
if IS_WINDOWS then
	vim.o.backupdir = HOME .. "\\.vim\\backup"
	vim.o.dir = HOME .. "\\.vim\\swapfiles"
else
	vim.o.backupdir = HOME .. "/.vim/backup"
	vim.o.dir = HOME .. "/.vim/swapfiles"
end
vim.o.mouse = "a"
vim.o.cursorline = true
vim.opt.diffopt:append({ "iwhiteall" })
vim.opt.shortmess:append("I")
-- vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"

-- leader is SPACE key
vim.g.mapleader = " "

-- vim.g.clipboard = {
-- 	name = "OSC 52",
-- 	copy = {
-- 		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
-- 		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
-- 	},
-- 	paste = {
-- 		["+"] = require("vim.ui.clipboard.osc52").paste("+"),
-- 		["*"] = require("vim.ui.clipboard.osc52").paste("*"),
-- 	},
-- }
