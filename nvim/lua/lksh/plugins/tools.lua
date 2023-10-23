return function()
	return {
		------------------
		--     TOOLS    --
		------------------
		"github/copilot.vim",        -- AI code completion
		"preservim/nerdcommenter",   -- comment line with <leader>/
		"ahmedkhalf/project.nvim",   -- project manager and switcher
		"andweeb/presence.nvim",     -- discord presence for neovim
		"uga-rosa/ccc.nvim",         -- color picker
		"windwp/nvim-autopairs",     -- auto-create brackets/parentheses
		"windwp/nvim-ts-autotag",    -- autoclose/rename html tags
		"nvim-telescope/telescope.nvim", -- fuzzy finder
		"akinsho/toggleterm.nvim",   -- Terminal pane/tab/window handler
		{
			"sindrets/diffview.nvim",
			dependencies = "nvim-lua/plenary.nvim"
		}, -- git diff viewer
		{
			-- easier navigation between files
			"ThePrimeagen/harpoon",
			dependencies = "nvim-lua/plenary.nvim"
		},
		"ggandor/leap.nvim", -- move and jump to spots in code quickly
		{
			-- floating file explorer
			"nvim-tree/nvim-tree.lua",
			dependencies = { "nvim-tree/nvim-web-devicons" },
		},
		{ "kylechui/nvim-surround" },
		------------------
	}
end
