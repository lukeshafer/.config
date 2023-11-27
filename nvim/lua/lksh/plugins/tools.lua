return function()
	return {
		------------------
		--     TOOLS    --
		------------------
		-- AI code completion
		--{
			--"github/copilot.vim",
			--event = "InsertEnter",
			--config = function()
				--vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
				--vim.g.copilot_no_tab_map = true
			--end
		--},

		-- comment line with <leader>/
		{ "preservim/nerdcommenter",       event = "VeryLazy" },

		-- color picker
		{
			"uga-rosa/ccc.nvim",
			event = "VeryLazy",
			config = function()
				vim.api.nvim_set_keymap("n", "cp", ":CccPick<CR>", { noremap = true })
			end
		},

		-- auto-create brackets/parentheses
		{
			'windwp/nvim-autopairs',
			event = "InsertEnter",
			opts = {} -- this is equalent to setup({}) function
		},

		-- autoclose/rename html tags
		{
			"windwp/nvim-ts-autotag",
			event = "InsertEnter",
			config = function()
				require('nvim-ts-autotag').setup()
			end
		},

		-- fuzzy finder
		{ "nvim-telescope/telescope.nvim", lazy = true },

		-- Terminal pane/tab/window handler
		{ "akinsho/toggleterm.nvim",       event = "VeryLazy" },

		-- git diff viewer
		{
			"sindrets/diffview.nvim",
			event = "VeryLazy",
			dependencies = "nvim-lua/plenary.nvim"
		},

		-- move and jump to spots in code quickly
		{
			"ggandor/leap.nvim",
			event = "BufEnter",
			config = function()
				require('leap').add_default_mappings()
			end
		},

		-- easier navigation between files
		{
			"ThePrimeagen/harpoon",
			event = "VeryLazy",
			dependencies = "nvim-lua/plenary.nvim"
		},

		-- floating file explorer
		{
			"nvim-tree/nvim-tree.lua",
			event = "VeryLazy",
			dependencies = { "nvim-tree/nvim-web-devicons" },
		},

		-- project-wide typescript checker
		{
			'dmmulroy/tsc.nvim',
			config = function()
				require('tsc').setup()
			end
		},

		-- tools for surrounding text
		{
			"kylechui/nvim-surround",
			version = "*", -- Use for stability; omit to use `main` branch for the latest features
			event = "VeryLazy",
			config = function()
				require("nvim-surround").setup({
					-- Configuration here, or leave empty to use defaults
				})
			end
		}
		------------------
	}
end
