require("plugin-config.mason")
--require("plugin-config.lspconfig")
require("plugin-config.cmp")
require("plugin-config.nvim-lint")

require("plugin-config.telescope")
require("plugin-config.nvim-tree")
require("plugin-config.bufferline")
require("plugin-config.treesitter")
require("plugin-config.prettier")
require("plugin-config.null-ls")
require("plugin-config.packer")
require("lualine").setup()
require("penvim").setup()
require("nvim-highlight-colors").setup({
	render = "background", -- or 'foreground' or 'first_column'
	enable_named_colors = true,
	enable_tailwind = true,
})
