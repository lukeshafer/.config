local nvim_treesitter = require("nvim-treesitter")
nvim_treesitter.install({
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
})

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function()
		nvim_treesitter.update()
	end,
})
