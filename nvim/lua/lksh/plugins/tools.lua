return function()
	return {
		------------------
		--     TOOLS    --
		------------------
		-- AI code completion
		{
			"github/copilot.vim",
			event = "VeryLazy",
			config = function()
				vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
				vim.g.copilot_no_tab_map = true
			end
		},

		-- comment line with <leader>/
		"preservim/nerdcommenter",

		-- project manager and switcher
		--{
			--"ahmedkhalf/project.nvim",
			--config = function()
				--require("project_nvim").setup({
					--detection_methods = { "pattern", "lsp" },
					--patterns = { ".git", ".gitignore" },
				--})
			--end
		--},

		-- color picker
		{
			"uga-rosa/ccc.nvim",
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
		"windwp/nvim-ts-autotag",

		-- fuzzy finder
		"nvim-telescope/telescope.nvim",

		-- Terminal pane/tab/window handler
		"akinsho/toggleterm.nvim",

		-- git diff viewer
		{
			"sindrets/diffview.nvim",
			dependencies = "nvim-lua/plenary.nvim"
		},

		-- move and jump to spots in code quickly
		{
			"ggandor/leap.nvim",
			config = function()
				require('leap').add_default_mappings()
			end
		},

		-- easier navigation between files
		{
			"ThePrimeagen/harpoon",
			dependencies = "nvim-lua/plenary.nvim"
		},

		-- floating file explorer
		{
			"nvim-tree/nvim-tree.lua",
			dependencies = { "nvim-tree/nvim-web-devicons" },
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
