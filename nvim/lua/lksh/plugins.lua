local utils = require("lksh.utils")

if not vim.version.range(">=0.12.0"):has(vim.version()) then
	vim.notify("Neovim plugins require version 0.12.0 or later.", vim.log.levels.ERROR)
	return
end

local Plugins = {}

function Plugins.init()
	vim.pack.add({
		utils.plugin("nvim-mini/mini.nvim"),
		utils.plugin("stevearc/oil.nvim"),
		utils.plugin("stevearc/conform.nvim"),
		utils.plugin("williamboman/mason.nvim"),
		utils.plugin("neovim/nvim-lspconfig"),
		utils.plugin("nvim-treesitter/nvim-treesitter"),
		utils.plugin("windwp/nvim-ts-autotag"),
		utils.plugin("nvim-treesitter/nvim-treesitter-context"),
	})
end

return Plugins
