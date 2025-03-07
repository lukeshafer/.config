local IS_WINDOWS = vim.uv.os_uname().sysname == "Windows_NT"
HOME = os.getenv("HOME")
if not HOME then
	HOME = os.getenv("USERPROFILE")
	IS_WINDOWS = true
end

-- Required for NvimTree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Editor Settings
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.background = "dark" -- sets light/dark for some colorschemes
vim.opt.number = true
vim.opt.numberwidth = 2
if IS_WINDOWS then
	vim.opt.backupdir = HOME .. "\\.vim\\backup"
	vim.opt.dir = HOME .. "\\.vim\\swapfiles"
else
	vim.opt.backupdir = HOME .. "/.vim/backup"
	vim.opt.dir = HOME .. "/.vim/swapfiles"
end
vim.opt.mouse = "a"
vim.opt.cursorline = true
vim.opt.diffopt:append { "iwhiteall" }
-- vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"

-- leader is SPACE key
vim.g.mapleader = " "
