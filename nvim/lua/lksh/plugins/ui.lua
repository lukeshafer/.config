local atWork = os.getenv("PC_CONTEXT") == "work"

return function()
	return {
		------------------
		--  UI HELPERS  --
		------------------
		-- treesitter, parses code for better colors
		"nvim-treesitter/nvim-treesitter",

		-- shows parent context, like the current function/method, at the top of code
		{ "nvim-treesitter/nvim-treesitter-context", event = "VeryLazy" },

		"nvim-tree/nvim-web-devicons",

		-- status line, bottom
		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons", opt = true }
		},

		-- highlights matches to the word under the cursor
		{
			"RRethy/vim-illuminate",
			event = "VeryLazy",
			config = function()
				require('illuminate').configure()
			end
		},

		-- git blame inline
		{
			"APZelos/blamer.nvim",
			event = "VeryLazy",
			config = function()
				vim.g.blamer_enabled = 1
			end
		},

		-- inline git helpers
		{
			'lewis6991/gitsigns.nvim',
			opts = {}
		},

		-- better diagnostics
		{
			"folke/trouble.nvim",
			dependencies = "nvim-tree/nvim-web-devicons"
		},

		"folke/zen-mode.nvim",

		-- highlight hex color strings e.g. #CCCCFF
		{
			"brenoprata10/nvim-highlight-colors",
			config = function()
				require("nvim-highlight-colors").setup({
					render = "background", -- or 'foreground' or 'first_column'
					enable_named_colors = true,
					enable_tailwind = true,
				})
			end
		},

		-- highlight todo comments, e.g. TODO:
		{
			"folke/todo-comments.nvim",
			dependencies = "nvim-lua/plenary.nvim",
			opts = {}
		},

		-- show indentation levels
		{
			"lukas-reineke/indent-blankline.nvim",
			main = "ibl",
			opts = {}
		},

		-- show package cost
		{
			'barrett-ruth/import-cost.nvim',
			build = atWork and 'sh install.sh npm' or 'sh install.sh pnpm',
			-- if on windows
			-- build = 'pwsh install.ps1 yarn',
			config = true
		},

		-- dim inactive code
		--{
		--"folke/twilight.nvim",
		--config = {
		--dimming = { alpha = 0.50 },
		--context = 20
		--},
		--},
		------------------
	}
end
