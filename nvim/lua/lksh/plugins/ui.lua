return function()
	return {
		------------------
		--  UI HELPERS  --
		------------------
		-- treesitter, parses code for better colors
		"nvim-treesitter/nvim-treesitter",

		-- shows parent context, like the current function/method, at the top of code
		"nvim-treesitter/nvim-treesitter-context",

		"nvim-tree/nvim-web-devicons",

		-- status line, bottom
		{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons", opt = true } },

		-- highlights matches to the word under the cursor
		"RRethy/vim-illuminate",

		-- git blame inline
		"APZelos/blamer.nvim",

		-- inline git helpers
		'lewis6991/gitsigns.nvim',

		-- better diagnostics
		{
			"folke/trouble.nvim",
			dependencies = "nvim-tree/nvim-web-devicons"
		},

		"folke/zen-mode.nvim",

		-- highlight hex color strings e.g. #CCCCFF
		"brenoprata10/nvim-highlight-colors",

		-- highlight todo comments, e.g. TODO:
		{ "folke/todo-comments.nvim",  dependencies = "nvim-lua/plenary.nvim" },

		-- show indentation levels
		"lukas-reineke/indent-blankline.nvim",

		-- dim inactive code
		{
			"folke/twilight.nvim",
			config = {
				dimming = { alpha = 0.50 },
				context = 20
			},
		},
		------------------
	}
end
