local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
	------------------
	-- COLOR THEMES --
	------------------
	"shaunsingh/moonlight.nvim",
	"sainnhe/sonokai",
	{ 'rose-pine/neovim',                               name = 'rose-pine' },
	"olivercederborg/poimandres.nvim",
	"Mofiqul/vscode.nvim",
	"rktjmp/lush.nvim", -- colorscheme MAKER
	{ dir = "~/.config/nvim/lua/lush_theme/stream.lua", name = "stream" },
	--"~/.config/nvim/lua/themes/stream",
	---- OLD COLOR SCHEMES ----
	--"folke/tokyonight.nvim",
	--"EdenEast/nightfox.nvim",
	--"frenzyexists/aquarium-vim",
	--"sainnhe/everforest",
	--"sainnhe/edge",
	--"rebelot/kanagawa.nvim",
	--"mhartington/oceanic-next",
	--"savq/melange",
	--"olimorris/onedarkpro.nvim",
	--{ "catppuccin/nvim", name = "catppuccin" },
	--{ 'embark-theme/vim', name = 'embark' },
	--"rmehri01/onenord.nvim",
	--{ 'Everblush/nvim', name = 'everblush' },
	--"Yazeed1s/oh-lucy.nvim",
	------------------

	------------------
	--  UI HELPERS  --
	------------------
	{ "nvim-treesitter/nvim-treesitter", },                                                      -- treesitter, parses code for better colors
	"nvim-treesitter/nvim-treesitter-context",                                                   -- shows parent context, like the current function/method, at the top of code
	"nvim-tree/nvim-web-devicons",                                                               --
	{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons", opt = true } }, -- status line, bottom
	"RRethy/vim-illuminate",                                                                     -- highlights matches to the word under the cursor
	"APZelos/blamer.nvim",                                                                       -- git blame inline
	'lewis6991/gitsigns.nvim',                                                                   -- inline git helpers
	{ "folke/trouble.nvim",        dependencies = "nvim-tree/nvim-web-devicons" },               -- better diagnostics
	"folke/zen-mode.nvim",
	"brenoprata10/nvim-highlight-colors",                                                        -- highlight hex color strings e.g. #CCCCFF
	{ "folke/todo-comments.nvim",        dependencies = "nvim-lua/plenary.nvim" },               -- highlight todo comments, e.g. TODO:
	"lukas-reineke/indent-blankline.nvim",                                                       --
	{
		"folke/twilight.nvim",
		config = {
			dimming = { alpha = 0.50 },
			context = 20
		},
	},
	------------------

	------------------
	--     TOOLS    --
	------------------
	"github/copilot.vim",          -- AI code completion
	"preservim/nerdcommenter",     -- comment line with <leader>/
	"ahmedkhalf/project.nvim",     -- project manager and switcher
	"andweeb/presence.nvim",       -- discord presence for neovim
	"uga-rosa/ccc.nvim",           -- color picker
	"windwp/nvim-autopairs",       -- auto-create brackets/parentheses
	"windwp/nvim-ts-autotag",      -- autoclose/rename html tags
	"nvim-telescope/telescope.nvim", -- fuzzy finder
	"akinsho/toggleterm.nvim",     -- Terminal pane/tab/window handler
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
		tag = "nightly"
	},
	{ "kylechui/nvim-surround" },
	------------------

	------------------
	--  LANGUAGES   --
	------------------
	--Languages without LSP config
	--use { "ckipp01/nvim-jenkinsfile-linter", requires = { "nvim-lua/plenary.nvim" } }  lint jenkinsfiles (no lsp)
	--use { "lankavitharana/ballerina-vim" }                                           lint ballerina (no lsp)
	--use { "jose-elias-alvarez/null-ls.nvim" }
	{ "ckipp01/nvim-jenkinsfile-linter", dependencies = { "nvim-lua/plenary.nvim" } },
	"lankavitharana/ballerina-vim",
	"jose-elias-alvarez/null-ls.nvim",

	-- LSP Config Handler
	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = {
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
	},

	-- FUN
	"seandewar/nvimesweeper",
})
