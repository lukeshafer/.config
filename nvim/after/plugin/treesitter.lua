require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all"
	ensure_installed = {
		"css",
		"typescript",
		"tsx",
		"astro",
		"lua",
		"html",
		"svelte",
		"gitcommit",
		"gitignore",
		"http",
		"jsdoc",
		"javascript",
		"json",
		"json5",
		"markdown",
		"prisma",
		"python",
		"rescript",
		"scss",
		"sql",
		"toml",
		"yaml",
		"bash",
		"comment",
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = false,

	highlight = {
		enable = true,
	},

	indent = {
		enable = true,
	},

	autotag = {
		enable = true,
	}
})
