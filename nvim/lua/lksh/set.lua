HOME = os.getenv("HOME")

-- Required for NvimTree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Editor Settings
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.termguicolors = true
vim.opt.expandtab = true

-- vim.opt.tCo = 256
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.backupdir = HOME .. "/.vim/backup"
vim.opt.dir = HOME .. "/.vim/swapfiles"
vim.cmd("let mapleader = ' '")
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
vim.opt.mouse = "a"
vim.opt.cursorline = true
--vim.opt.wrap = false

vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.foldcolumn = "1"

local fcs = vim.opt.fillchars:get()
local foldopen = fcs.foldopen or "-"
local foldclose = fcs.foldclose or "+"

-- Stolen from Akinsho
local function get_fold(lnum)
  if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then
    return " "
  end
  return vim.fn.foldclosed(lnum) == -1 and foldopen or foldclose
end

_G.get_statuscol = function()
  return "%s%l " .. get_fold(vim.v.lnum) .. " "
end

vim.o.statuscolumn = "%!v:lua.get_statuscol()"
