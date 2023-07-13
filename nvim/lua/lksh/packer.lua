return require("packer").startup(function(use)
	-- Packer manages itself!
	use({ "wbthomason/packer.nvim" })
	vim.cmd([[
	  augroup packer_user_config
		autocmd!
		autocmd BufWritePost packer.lua source <afile> | PackerSync
	  augroup end
	]])
	--

	--
	------------------
	-- COLOR THEMES --
	------------------
	--use("folke/tokyonight.nvim")
	--use("EdenEast/nightfox.nvim")
	use("shaunsingh/moonlight.nvim")
	--use("frenzyexists/aquarium-vim")
	use("sainnhe/sonokai")
	--use("sainnhe/everforest")
	--use("sainnhe/edge")
	--use("rebelot/kanagawa.nvim")
	--use("mhartington/oceanic-next")
	use({
		"rose-pine/neovim",
		as = "rose-pine",
		config = function()
			require("rose-pine").setup({
				--dark_variant = "moon",
			})
		end
	})
	--use("savq/melange")
	use("Mofiqul/vscode.nvim")
	--use("olimorris/onedarkpro.nvim")
	--use { "catppuccin/nvim", as = "catppuccin" }
	--use { 'embark-theme/vim', as = 'embark' }
	--use 'rmehri01/onenord.nvim'
	use {
		'olivercederborg/poimandres.nvim',
		config = function()
			require('poimandres').setup {
				-- leave this setup function empty for default config
				-- or refer to the configuration section
				-- for configuration options
			}
		end
	}
	--use { 'Everblush/nvim', as = 'everblush' }
	--use 'Yazeed1s/oh-lucy.nvim'

	--use("rktjmp/lush.nvim") -- colorscheme MAKER
	------------------
	--

	--
	------------------
	--  UI HELPERS  --
	------------------
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) -- treesitter, parses code for better colors
	--use("nvim-treesitter/nvim-treesitter-context")             -- shows current context, aka function/block parent
	--use("nvim-treesitter/playground")                          -- tool to view treesitter nodes
	use("kyazdani42/nvim-web-devicons")

	use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" })  -- tabline for buffers, top
	use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } }) -- status line, bottom
	--use({
	--"rebelot/heirline.nvim",
	---- You can optionally lazy-load heirline on UiEnter
	---- to make sure all required plugins and colorschemes are loaded before setup
	---- event = "UiEnter",
	--config = function()
	--require("heirline").setup({

	--})
	--end
	--})


	use({
		-- highlight todo comments, e.g. TODO:
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup()
		end,
	})
	use("RRethy/vim-illuminate") -- highlights matches to the word under the cursor

	-- rainbow is no longer maintained, look at HiPhish/nvim-ts-rainbow2
	--use("p00f/nvim-ts-rainbow")                -- rainbow nested parentheses/brackets
	use({ "brenoprata10/nvim-highlight-colors" }) -- highlight hex color strings e.g. #CCCCFF
	use("APZelos/blamer.nvim")                 -- git blame inline

	use({
		-- shows tasks that are running (formatters, lsp, etc)
		"j-hui/fidget.nvim",
		tag = "legacy", -- being rewritten, this prevents breaking changes, idk
		config = function()
			require("fidget").setup()
		end,
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			--vim.opt.list = true;
			--vim.opt.listchars:append "eol:↴"
			--vim.opt.listchars:append "space:⋅"
			require("indent_blankline").setup({
				show_end_of_line = true,
				show_current_context = true,
			})
		end,
	})
	use {
		-- inline git helpers
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup()
		end
	}
	use {
		-- better diagnostics
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end
	}
	--use {
	---- dims all code but the block you're editing
	--"folke/twilight.nvim",
	--config = function()
	--require("twilight").setup {
	---- your configuration comes here
	---- or leave it empty to use the default settings
	---- refer to the configuration section below
	--}
	--end
	--}
	use { "folke/zen-mode.nvim" }


	------------------
	--

	--
	------------------
	--     TOOLS    --
	------------------
	use("github/copilot.vim") -- ai pair programmer
	--use("abstract-ide/penvim") -- sets working dir to project root
	use("preservim/nerdcommenter")                                     -- comment line with <leader>/
	--use("mvolkmann/vim-tag-comment") -- html tag comments
	use({ "ahmedkhalf/project.nvim" })                                 -- project manager and switcher
	use("andweeb/presence.nvim")                                       -- discord presence for neovim
	use("uga-rosa/ccc.nvim")                                           -- color picker
	use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" }) -- git diff viewer
	use({ "akinsho/toggleterm.nvim", tag = "*" })                      -- Terminal pane/tab/window handler
	use({ "gpanders/editorconfig.nvim" })                              -- .editorconfig support (unneeded on neovim 0.9 and later)
	use({
		-- move and jump to spots in code quickly
		"ggandor/leap.nvim",
		config = function()
			require('leap').add_default_mappings()
		end
	})

	use({
		-- floating file explorer
		"nvim-tree/nvim-tree.lua",
		tag = "nightly",          -- optional, updated every week. (see issue #1193)
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
	})

	use({
		-- auto-create brackets/parentheses
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	})

	use({
		-- autoclose/rename html tags
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	})

	use({
		-- surround using brackets, quotes, etc with shortcuts
		"kylechui/nvim-surround",
		tag = "*", -- use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup()
		end,
	})

	use({
		-- fuzzy finder
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use({
		-- neogen, generate comment annotations with :Neogen
		"danymat/neogen",
		requires = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("neogen").setup({})
		end,
		-- Uncomment next line if you want to follow only stable versions
		-- tag = "*"
	})
	use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' } -- some fold thing, idk

	------------------
	--

	--
	------------------
	--  LANGUAGES   --
	------------------
	-- Languages without LSP config
	use({ "ckipp01/nvim-jenkinsfile-linter", requires = { "nvim-lua/plenary.nvim" } }) -- lint jenkinsfiles (no lsp)
	use("lankavitharana/ballerina-vim")                                             -- lint ballerina (no lsp)
	use("jose-elias-alvarez/null-ls.nvim")

	-- LSP Config Handler
	use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	})
	------------------
	--

	--
	------------------
	--     FUN      --
	------------------
	--
	use("seandewar/nvimesweeper")
end)
