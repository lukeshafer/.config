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
	use { "shaunsingh/moonlight.nvim" }
	use { "sainnhe/sonokai" }
	use { "rose-pine/neovim", as = "rose-pine", config = function() require("rose-pine").setup {} end }
	use { 'olivercederborg/poimandres.nvim', config = function() require('poimandres').setup {} end }
	use("Mofiqul/vscode.nvim")
	use("rktjmp/lush.nvim") -- colorscheme MAKER

	---- OLD COLOR SCHEMES ----
	--use("folke/tokyonight.nvim")
	--use("EdenEast/nightfox.nvim")
	--use("frenzyexists/aquarium-vim")
	--use("sainnhe/everforest")
	--use("sainnhe/edge")
	--use("rebelot/kanagawa.nvim")
	--use("mhartington/oceanic-next")
	--use("savq/melange")
	--use("olimorris/onedarkpro.nvim")
	--use { "catppuccin/nvim", as = "catppuccin" }
	--use { 'embark-theme/vim', as = 'embark' }
	--use 'rmehri01/onenord.nvim'
	--use { 'Everblush/nvim', as = 'everblush' }
	--use 'Yazeed1s/oh-lucy.nvim'
	------------------
	--

	--
	------------------
	--  UI HELPERS  --
	------------------
	--use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" })  -- tabline for buffers, top
	use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }                                                             -- treesitter, parses code for better colors
	use { "nvim-treesitter/nvim-treesitter-context" }                                                                        -- shows parent context, like the current function/method, at the top of code
	use { "kyazdani42/nvim-web-devicons" }
	use { "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } }                           -- status line, bottom
	use { "RRethy/vim-illuminate" }                                                                                          -- highlights matches to the word under the cursor
	use { "APZelos/blamer.nvim" }                                                                                            -- git blame inline
	use { 'lewis6991/gitsigns.nvim', config = function() require('gitsigns').setup {} end }                                  -- inline git helpers
	use { "folke/trouble.nvim", requires = "nvim-tree/nvim-web-devicons", config = function() require("trouble").setup {} end } -- better diagnostics
	use { "folke/zen-mode.nvim" }
	use { "brenoprata10/nvim-highlight-colors" }                                                                             -- highlight hex color strings e.g. #CCCCFF
	use { "j-hui/fidget.nvim", tag = "legacy", config = function() require("fidget").setup() end, }                          -- shows tasks that are running (formatters, lsp, etc)
	use {                                                                                                                    -- highlight todo comments, e.g. TODO:
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function() require("todo-comments").setup {} end,
	}
	use {
		"lukas-reineke/indent-blankline.nvim",
		config = function() require("ibl").setup({}) end,
	}
	use {
		-- dims all code but the block you're editing
		"folke/twilight.nvim",
		config = function()
			require("twilight").setup {
				dimming = {
					alpha = 0.50, -- amount of dimming
				},
				context = 20, -- amount of lines we will try to show around the current line
			}
		end
	}



	------------------
	--

	--
	------------------
	--     TOOLS    --
	------------------
	use { "github/copilot.vim" }                                                                        -- ai pair programmer
	use { "preservim/nerdcommenter" }                                                                   -- comment line with <leader>/
	use { "ahmedkhalf/project.nvim" }                                                                   -- project manager and switcher
	use { "andweeb/presence.nvim" }                                                                     -- discord presence for neovim
	use { "uga-rosa/ccc.nvim" }                                                                         -- color picker
	use { "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" }                                -- git diff viewer
	use { "akinsho/toggleterm.nvim", tag = "*" }                                                        -- Terminal pane/tab/window handler
	use { "gpanders/editorconfig.nvim" }                                                                -- .editorconfig support (unneeded on neovim 0.9 and later)
	use { "ThePrimeagen/harpoon", requires = "nvim-lua/plenary.nvim" }                                  -- easier navigation between files
	use { "ggandor/leap.nvim", config = function() require('leap').add_default_mappings() end }         -- move and jump to spots in code quickly
	use { "nvim-tree/nvim-tree.lua", tag = "nightly", requires = { "nvim-tree/nvim-web-devicons" }, }   -- floating file explorer
	use { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup() end, }         -- auto-create brackets/parentheses
	use { "windwp/nvim-ts-autotag", config = function() require("nvim-ts-autotag").setup() end, }       -- autoclose/rename html tags
	use { "kylechui/nvim-surround", tag = "*", config = function() require("nvim-surround").setup() end, } -- surround using brackets, quotes, etc with shortcuts
	use { "nvim-telescope/telescope.nvim", tag = "0.1.0", requires = { { "nvim-lua/plenary.nvim" } } }  -- fuzzy finder
	--use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }                            -- some fold thing, idk

	------------------
	--

	--
	------------------
	--  LANGUAGES   --
	------------------
	-- Languages without LSP config
	use { "ckipp01/nvim-jenkinsfile-linter", requires = { "nvim-lua/plenary.nvim" } } -- lint jenkinsfiles (no lsp)
	use { "lankavitharana/ballerina-vim" }                                         -- lint ballerina (no lsp)
	use { "jose-elias-alvarez/null-ls.nvim" }

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
