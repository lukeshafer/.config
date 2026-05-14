local utils = require("lksh.utils")

if not vim.version.range(">=0.12.0"):has(vim.version()) then
	vim.notify("Neovim plugins require version 0.12.0 or later.", vim.log.levels.ERROR)
	return
end

local Plugins = {}

function Plugins.init()
	local p = utils.parse_plugin_list({
		["nvim-mini/mini.nvim"] = {},
		["stevearc/oil.nvim"] = {},
		["stevearc/conform.nvim"] = {},
		["williamboman/mason.nvim"] = {},
		["neovim/nvim-lspconfig"] = {},
		["nvim-treesitter/nvim-treesitter"] = {},
		["windwp/nvim-ts-autotag"] = {},
		["nvim-treesitter/nvim-treesitter-context"] = {},
	})

	-- utils.print_table(p)
	vim.pack.add(p.plugin_list)
	-- p.setup()
end

return Plugins
