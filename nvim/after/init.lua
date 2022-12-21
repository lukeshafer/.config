require("penvim").setup({
	rooter = {
		enable = true, -- enable/disable rooter
		patterns = { ".__nvim__.lua", ".git" },
	},
})

require("nvim-highlight-colors").setup({
	render = "background", -- or 'foreground' or 'first_column'
	enable_named_colors = true,
	enable_tailwind = true,
})
vim.g.blamer_enabled = 1
