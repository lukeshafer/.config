vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

vim.pack.add({ "https://github.com/kylechui/nvim-surround" })
require("nvim-surround").setup({})

local map_opts = { noremap = true, silent = true }
vim.keymap.set("n", "<C-Up>", ":m -2<CR>", { desc = "Move line up" })
vim.keymap.set("n", "<C-k>", ":m -2<CR>", { desc = "Move line up" })
vim.keymap.set("n", "<C-Down>", ":m +1<CR>", { desc = "Move line down" })
vim.keymap.set("n", "<C-j>", ":m +1<CR>", { desc = "Move line down" })
vim.keymap.set("n", ";", ":", { desc = "Enter command mode" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent and reselect" })
vim.keymap.set("v", "<", "<gv", { desc = "Dedent and reselect" })
vim.keymap.set("n", "<leader><Esc>", ":noh<cr>", { desc = "Clear search highlight" })
