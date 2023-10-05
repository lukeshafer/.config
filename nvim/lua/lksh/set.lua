HOME = os.getenv("HOME")

-- Required for NvimTree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Editor Settings
vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
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
vim.opt.cursorline = true
--vim.opt.wrap = false
