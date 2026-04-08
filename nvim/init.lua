if vim.g.vscode then
	require("lksh.vsc-config")
	return
end

local utils = require("lksh.utils")
local lsp = require("lksh.lsp")
local commands = require("lksh.commands")
local keymaps = require("lksh.keymaps")
local statusline = require("lksh.statusline")

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
vim.opt.diffopt:append({ "iwhiteall" })
vim.opt.shortmess:append("I")

if utils.IS_WINDOWS then
	vim.o.backupdir = utils.HOME_DIR .. "\\.vim\\backup"
	vim.o.dir = utils.HOME_DIR .. "\\.vim\\swapfiles"
else
	vim.o.backupdir = utils.HOME_DIR .. "/.vim/backup"
	vim.o.dir = utils.HOME_DIR .. "/.vim/swapfiles"
end

vim.g.mapleader = " "

if vim.version.range(">=0.12.0"):has(vim.version()) then
	require("lksh.plugins").init()
else
	require("lksh.plugins-lazy")
end

lsp.init()
commands.init()
keymaps.init()
statusline.init()
