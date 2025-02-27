if vim.g.vscode then
	require("lksh.vsc-plugins")
else
	require("lksh.plugins")
end

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
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
vim.opt.mouse = "a"
vim.opt.cursorline = true
-- vim.opt.foldmethod = "indent"

local function map(mode, shortcut, command, noremap)
	noremap = noremap or true
	vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = noremap })
end

-- leader is SPACE key
vim.g.mapleader = " "

--------NORMAL MODE---------
-- CTRL n opens new tab
map("n", "<C-n>", ":tabnew <CR>")
-- CTRL e toggles file browser
-- CTRL Up/Down moves lines up/down
map("n", "<C-Up>", ":m -2<CR>")
map("n", "<C-k>", ":m -2<CR>")
map("n", "<C-Down>", ":m +1<CR>")
map("n", "<C-j>", ":m +1<CR>")
-- ESC also clears highlighting
map("n", "<leader><Esc>", ":noh<cr>")
-- SPACE Up/Down/Left/Right moves to other window
map("n", "<leader>k", "<C-w>k")
map("n", "<leader>j", "<C-w>j")
map("n", "<leader>h", "<C-w>h")
map("n", "<leader>l", "<C-w>l")
-- x deletes character but does not put in clipboard"
map("n", "x", '"_x')
map("n", "<leader>x", ":bprevious|bdelete #<cr>")
map("n", "<leader>XX", ":bdelete!<cr>")
-- Semicolon is also Colon
map("n", ";", ":")
-- Leader+Y copies to system clipboard
map("n", "<leader>y", '"+y')
map("v", "<leader>y", '"+y')
map("n", "<leader>s", ":Inspect<cr>")
-- Leader+T opens terminal in pane
-- map("n", "<leader>t", ":belowright 15sp|term<cr>")

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>d", function()
	vim.diagnostic.open_float({ source = true })
end, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

--------INSERT MODE---------
map("i", "<C-h>", "<Left>")
map("i", "<C-k>", "<Up>")
map("i", "<C-l>", "<Right>")
map("i", "<C-j>", "<Down>")

--------VISUAL MODE---------
--
-- CTRL + BRACKET wraps selected text in the bracket
map("v", "<C-9>", "c()<Esc>hp")
map("v", "<C-(>", "c()<Esc>hp")
-- Indenting keeps previous highlight
map("v", ">", ">gv")
map("v", "<", "<gv")

-- nvim terminal mappings
-- Escape gets out of insert (in terminal)
map("t", "<Esc>", "<C-\\><C-n>")
