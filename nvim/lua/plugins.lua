return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	use("folke/tokyonight.nvim")
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup()
		end,
	})
	use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" })

	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})

	use("hrsh7th/nvim-cmp") -- Autocompletion plugin
	use("hrsh7th/cmp-nvim-lsp") -- LSP source for nvim-cmp
	use("saadparwaiz1/cmp_luasnip") -- Snippets source for nvim-cmp
	use("L3MON4D3/LuaSnip") -- Snippets plugin
	--use("mhartington/formatter.nvim")
	--use("sbdchd/neoformat")
	use("mfussenegger/nvim-lint")

	use("jose-elias-alvarez/null-ls.nvim")
	use("MunifTanjim/prettier.nvim")

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("nvim-treesitter/nvim-treesitter-context")

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
		tag = "nightly", -- optional, updated every week. (see issue #1193)
	})

	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})
	use("RRethy/vim-illuminate") -- highlights matches to the word under the cursor
	use("p00f/nvim-ts-rainbow")
	use("Abstract-IDE/penvim") -- sets working dir to project root

	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	})
	use({
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	})
	use("preservim/nerdcommenter") -- auto comment CTRL+/

	use {
    "lewis6991/hover.nvim",
    config = function()
        require("hover").setup {
            init = function()
                -- Require providers
                require("hover.providers.lsp")
                -- require('hover.providers.gh')
                -- require('hover.providers.jira')
                -- require('hover.providers.man')
                -- require('hover.providers.dictionary')
            end,
            preview_opts = {
                border = nil
            },
            -- Whether the contents of a currently open hover window should be moved
            -- to a :h preview-window when pressing the hover keymap.
            preview_window = false,
            title = true
        }

        -- Setup keymaps
        vim.keymap.set("n", "K", require("hover").hover, {desc = "hover.nvim"})
        vim.keymap.set("n", "gK", require("hover").hover_select, {desc = "hover.nvim (select)"})
    end
}

	use("brenoprata10/nvim-highlight-colors")
end)
