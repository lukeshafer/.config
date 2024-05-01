require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all"
	ensure_installed = {
		"css",
		"typescript",
		"tsx",
		"astro",
		"lua",
		"html",
		"gitignore",
		"http",
		"jsdoc",
		"javascript",
		"json",
		"json5",
		"markdown",
		"sql",
		"toml",
		"yaml",
		"bash",
		"comment",
	},

	highlight = { enable = true },
	indent = { enable = true },
	autotag = { enable = true },
})
