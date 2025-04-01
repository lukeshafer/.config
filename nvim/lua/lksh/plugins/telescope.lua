return {
	"nvim-telescope/telescope.nvim", -- fuzzy finder
	lazy = true,
	config = {
		defaults = { file_ignore_patterns = { "node_modules", "dist", "build", ".git" } },
		pickers = { find_files = { hidden = true } },
	},
	keys = {
		{
			"ff",
			function()
				require("telescope.builtin").find_files()
			end,
		},
		{
			"fg",
			function()
				require("telescope.builtin").live_grep()
			end,
		},
		{
			"fb",
			function()
				require("telescope.builtin").buffers()
			end,
		},
		{
			"fh",
			function()
				require("telescope.builtin").help_tags()
			end,
		},
	},
}
