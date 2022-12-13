HOME = os.getenv("HOME")

-- Required for NvimTree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Editor Settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.termguicolors = true
-- vim.opt.tCo = 256
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 3
vim.opt.backupdir = HOME .. "/.vim/backup"
vim.opt.dir = HOME .. "/.vim/swapfiles"
vim.cmd("let mapleader = ' '")
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
vim.opt.mouse = "a"
--vim.opt.wrap = false

require("plugins")

-- options: default, atlantis, andromeda, shusia, maia, espresso
vim.g.sonokai_better_performance = 1

local dir = vim.fn.getcwd()

vim.cmd([[colorscheme tokyonight]])
if dir == HOME .. "/repos/crmi-common" then
	vim.cmd([[colorscheme carbonfox]])
elseif dir == HOME .. "/repos/contact-integrations" then
	vim.cmd([[colorscheme nightfox]])
elseif dir == HOME .. "/repos/crmi-web-to-case" then
	vim.cmd([[colorscheme terafox]])
elseif dir == HOME .. "/.config" then
	vim.cmd([[colorscheme darkblue]])
end

require("plugin-config")
require("keybindings")
