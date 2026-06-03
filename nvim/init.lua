if vim.g.vscode then
  require("lksh.vsc-config")
  return
end

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
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevelstart = 1
vim.o.foldtext = ""
vim.opt.fillchars = {
  -- fold = "󰇘",
  foldopen = "󰅀",
  foldclose = "󰅂",
  foldinner = " ",
  -- foldsep = " ",
}

vim.o.backupdir = vim.fn.expand("~/.vim/backup")
vim.o.dir = vim.fn.expand("~/.vim/swapfiles")

vim.g.mapleader = " "

LKSH = {
  Keys = require("lksh.keymaps"),
  Cmds = require("lksh.commands"),
  Plugins = require("lksh.plugins"),
  LSP = require("lksh.lsp"),
  Statusline = require("lksh.statusline"),
  Tabline = require("lksh.tabline"),
  Utils = require("lksh.utils"),
}

LKSH.Keys.init()
LKSH.Cmds.init()
LKSH.Plugins.init()
LKSH.LSP.init()
LKSH.Statusline.init()
LKSH.Tabline.init()
