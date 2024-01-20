local atWork = os.getenv("PC_CONTEXT") == "work"

return function()
	return {
		------------------
		--  UI HELPERS  --
		------------------
		-- treesitter, parses code for better colors
		"nvim-treesitter/nvim-treesitter",

		-- shows parent context, like the current function/method, at the top of code
		--{ "nvim-treesitter/nvim-treesitter-context", event = "VeryLazy" },

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

		{
			"folke/zen-mode.nvim",
			opts = {
				window = {
					backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
					-- height and width can be:
					-- * an absolute number of cells when > 1
					-- * a percentage of the width / height of the editor when <= 1
					-- * a function that returns the width or the height
					width = 250, -- width of the Zen window
					height = 1, -- height of the Zen window
					-- by default, no options are changed for the Zen window
					-- uncomment any of the options below, or add other vim.wo options you want to apply
					options = {
						signcolumn = "no", -- disable signcolumn
						number = false, -- disable number column
						relativenumber = false, -- disable relative numbers
						-- cursorline = false, -- disable cursorline
						-- cursorcolumn = false, -- disable cursor column
						-- foldcolumn = "0", -- disable fold column
						-- list = false, -- disable whitespace characters
					},
				},
				plugins = {
					-- disable some global vim options (vim.o...)
					-- comment the lines to not apply the options
					options = {
						enabled = true,
						ruler = false, -- disables the ruler text in the cmd line area
						showcmd = false, -- disables the command in the last line of the screen
						-- you may turn on/off statusline in zen mode by setting 'laststatus'
						-- statusline will be shown only if 'laststatus' == 3
						laststatus = 3, -- turn off the statusline in zen mode
					},
				}
			}
		},

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
		--{
			--'barrett-ruth/import-cost.nvim',
			--build = atWork and 'sh install.sh npm' or 'sh install.sh pnpm',
			---- if on windows
			---- build = 'pwsh install.ps1 yarn',
			--config = true
		--},

		-- notification API
		{
			'rcarriga/nvim-notify',
			config = function()
				--local notify = require('notify')

				--vim.notify = function(message, level, opts)
					--return notify(message, level, opts) -- <-- Important to return the value from `nvim-notify`
				--end
			end
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
