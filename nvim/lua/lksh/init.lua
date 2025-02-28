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
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

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

local function map(mode, shortcut, command, noremap)
	noremap = noremap or true
	vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = noremap })
end

local map_opts = { noremap = true, silent = true }

-- leader is SPACE key
vim.g.mapleader = " "

--------NORMAL MODE---------
-- CTRL n opens new tab
-- map("n", "<C-n>", ":tabnew <CR>") -- TODO: delete this next commit
-- CTRL e toggles file browser
-- map("n", "<leader>e", ":Explore<cr>")

-- local netrw_buf --- @type integer
-- local netrw_win --- @type integer
-- local prev_buf --- @type integer
-- vim.keymap.set("n", "<leader>e", function()
-- 	if netrw_buf ~= vim.api.nvim_get_current_buf() then
-- 		prev_buf = vim.api.nvim_get_current_buf()
-- 	end
--
-- 	if netrw_buf == nil then
-- 		netrw_buf = vim.api.nvim_create_buf(false, true)
-- 	end
--
-- 	if netrw_win == nil or not vim.api.nvim_win_is_valid(netrw_win) then
-- 		netrw_win = vim.api.nvim_open_win(netrw_buf, true, {
-- 			-- relative = "editor",
-- 			width = 50,
-- 			split = "left",
-- 			style = "minimal",
-- 		})
-- 		vim.cmd("Explore")
-- 	else
-- 		vim.api.nvim_set_current_win(netrw_win)
-- 	end
-- end, map_opts)

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

vim.keymap.set("n", "<leader>d", function()
	vim.diagnostic.open_float({ source = true })
end, map_opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, map_opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, map_opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, map_opts)

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
