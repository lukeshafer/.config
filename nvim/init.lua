HOME = os.getenv("HOME")

-- Required for NvimTree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Editor Settings
vim.opt.termguicolors = true
-- vim.opt.tCo = 256
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.backupdir = HOME .. "/.vim/backup"
vim.opt.dir = HOME .. "/.vim/swapfiles"
vim.cmd("let mapleader = ' '")
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
vim.opt.mouse = "a"

require("plugins")

-- options: default, atlantis, andromeda, shusia, maia, espresso
vim.g.sonokai_style = "default"
vim.g.sonokai_better_performance = 1

local dir = vim.fn.getcwd()

if dir == HOME .. "/repos/crmi-web-to-case" then
	vim.g.sonokai_style = "shusia"
elseif dir == HOME .. "/repos/crmi-common" then
	vim.g.sonokai_style = "maia"
end

vim.cmd([[colorscheme tokyonight]])

require("plugin-config")
require("keybindings")
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
