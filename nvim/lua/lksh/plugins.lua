-- Ensure lazy is installed and install it
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

-- actual lazy configuration
local plugins = {
	-- colors i like
	--  - catppuccin/nvim {catppuccin}
	--  - Yazeed1s/oh-lucy.nvim {oh-lucy}
	--  - rose-pine/neovim {rose-pine}
	--  - sainnhe/everforest {everforest}
	{ -- CURRENT PRIMARY
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 5000,
		config = function()
			vim.cmd("color catppuccin")
		end,
	},

	------------------
	--      LSP     --
	------------------
	-- Formatter management
	{ "stevearc/conform.nvim", opts = {}, lazy = true },

	-- LSP Support
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
	},
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	{ "saadparwaiz1/cmp_luasnip" },
	{ "hrsh7th/cmp-nvim-lua" },

	-- Snippets
	{ "L3MON4D3/LuaSnip" },
	{ "rafamadriz/friendly-snippets" },

	------------------
	--    OTHER     --
	------------------

	"nvim-treesitter/nvim-treesitter",
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons", opt = true } }, -- status line, bottom
	{ "lewis6991/gitsigns.nvim", opts = {} }, -- inline git helpers
	{ "folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim", opts = {} }, -- highlight todo comments, e.g. TODO:
	{ "numToStr/Comment.nvim", opts = {}, lazy = false },
	{ "windwp/nvim-autopairs", event = "InsertEnter", opts = {} }, -- auto-create brackets/parentheses
	{ "windwp/nvim-ts-autotag", event = "InsertEnter", opts = {} }, -- autoclose/rename html tags
	{ "nvim-telescope/telescope.nvim", lazy = true }, -- fuzzy finder
	{ "akinsho/toggleterm.nvim", event = "VeryLazy", opts = { direction = "horizontal" } }, -- Terminal pane/tab/window handler
	{ "nvim-tree/nvim-tree.lua", event = "VeryLazy", dependencies = { "nvim-tree/nvim-web-devicons" } }, -- file explorer
	{ "sindrets/diffview.nvim", event = "VeryLazy", dependencies = "nvim-lua/plenary.nvim" }, -- git diff viewer
	{ "dmmulroy/ts-error-translator.nvim", opts = {} },
	{ "kylechui/nvim-surround", version = "*", event = "VeryLazy", opts = {} }, -- tools for surrounding text
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }, -- show indentation levels

	-- highlights matches to the word under the cursor
	{
		"RRethy/vim-illuminate",
		event = "VeryLazy",
		config = function()
			require("illuminate").configure({})
		end,
	},

	-- git blame inline
	{
		"APZelos/blamer.nvim",
		event = "VeryLazy",
		config = function()
			vim.g.blamer_enabled = 1
		end,
	},

	{
		"brenoprata10/nvim-highlight-colors", -- highlight hex color strings e.g. #CCCCFF, text-sky-700
		config = function()
			require("nvim-highlight-colors").setup({
				render = "background", -- 'foreground' or 'background' or 'virtual'
				enable_named_colors = false,
				enable_tailwind = true, -- bg-blue-450
			})
		end,
	},

	{
		"uga-rosa/ccc.nvim", -- color picker
		event = "VeryLazy",
		config = function()
			require("ccc").setup({})
			vim.api.nvim_set_keymap("n", "cp", ":CccPick<CR>", { noremap = true })
		end,
	},

	{
		"ggandor/leap.nvim", -- move and jump to spots in code quickly
		event = "BufEnter",
		config = function()
			require("leap").add_default_mappings()
		end,
	},

	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		main = "ts_context_commentstring",
		opts = {
			languages = {
				javascript = {
					__default = "// %s",
					jsx_element = "{/* %s */}",
					jsx_fragment = "{/* %s */}",
					jsx_attribute = "// %s",
					comment = "// %s",
				},
			},
		},
	},
}

require("lazy").setup(plugins)
