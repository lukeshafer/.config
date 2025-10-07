-- Ensure lazy is installed and install it
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

-- actual lazy configuration
local plugins = {
	{
		"kylechui/nvim-surround", -- tools for surrounding text
		version = "*",
		event = "VeryLazy",
		opts = {},
	},
}

require("lazy").setup(plugins)

local map_opts = { noremap = true, silent = true }
vim.keymap.set("n", "<C-Up>", ":m -2<CR>", map_opts)
vim.keymap.set("n", "<C-k>", ":m -2<CR>", map_opts)
vim.keymap.set("n", "<C-Down>", ":m +1<CR>", map_opts)
vim.keymap.set("n", "<C-j>", ":m +1<CR>", map_opts)
vim.keymap.set("n", ";", ":", map_opts)
vim.keymap.set("v", ">", ">gv", map_opts)
vim.keymap.set("v", "<", "<gv", map_opts)

vim.keymap.set("n", "<leader><Esc>", ":noh<cr>", map_opts)
