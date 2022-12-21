return require("packer").startup(function(use)
	-- Packer manages itself!
	use("wbthomason/packer.nvim")
	vim.cmd([[
	  augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	  augroup end
	]])
	--

	--
	------------------
	-- COLOR THEMES --
	------------------
	use("folke/tokyonight.nvim")
	use("EdenEast/nightfox.nvim")
	use("shaunsingh/moonlight.nvim")
	use("frenzyexists/aquarium-vim")
	use("sainnhe/sonokai")
	------------------
	--

	--
	------------------
	--  UI HELPERS  --
	------------------
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) -- treesitter, parses code for better colors
	use("nvim-treesitter/nvim-treesitter-context") -- shows current context, aka function/block parent
	use("nvim-treesitter/playground") -- tool to view treesitter nodes

	use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" }) -- tabline for buffers, top
	use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } }) -- status line, bottom

	use({ -- highlight todo comments, i.e. TODO:
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup()
		end,
	})
	use("RRethy/vim-illuminate") -- highlights matches to the word under the cursor
	use("p00f/nvim-ts-rainbow") -- rainbow nested parentheses/brackets
	use("brenoprata10/nvim-highlight-colors") -- highlight hex color strings i.e. #CCCCFF
	use("APZelos/blamer.nvim") -- git blame inline
	------------------
	--

	--
	------------------
	--     TOOLS    --
	------------------
	use("abstract-ide/penvim") -- sets working dir to project root
	use("preservim/nerdcommenter") -- comment line with <leader>/
	use("mvolkmann/vim-tag-comment") -- html tag comments

	use({ -- floating file explorer
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
		tag = "nightly", -- optional, updated every week. (see issue #1193)
	})

	use({ -- auto-create brackets/parentheses
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	})

	use({ -- autoclose/rename html tags
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	})

	use({ -- surround using brackets, quotes, etc with shortcuts
		"kylechui/nvim-surround",
		tag = "*", -- use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup()
		end,
	})

	use({ -- fuzzy finder
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	------------------
	--

	--
	------------------
	--  LANGUAGES   --
	------------------
	-- Languages without LSP config
	use({ "ckipp01/nvim-jenkinsfile-linter", requires = { "nvim-lua/plenary.nvim" } }) -- lint jenkinsfiles (no lsp)
	use("lankavitharana/ballerina-vim") -- lint ballerina (no lsp)
	--use("MunifTanjim/prettier.nvim")
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
end)

--vim.cmd([[
--augroup packer_user_config
--autocmd!
--autocmd BufWritePost packer.lua source <afile> | PackerSync
--augroup end
--]])
