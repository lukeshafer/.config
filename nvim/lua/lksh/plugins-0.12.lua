vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/hrsh7th/cmp-nvim-lsp",
	"https://github.com/hrsh7th/cmp-buffer",
	"https://github.com/hrsh7th/cmp-path",
	"https://github.com/saadparwaiz1/cmp_luasnip",
	"https://github.com/hrsh7th/cmp-nvim-lua",
	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/echasnovski/mini.colors",
	"https://github.com/echasnovski/mini.hues",
	"https://github.com/stevearc/conform.nvim", -- Formatter management
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/folke/todo-comments.nvim",
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/windwp/nvim-ts-autotag",
	"https://github.com/sindrets/diffview.nvim",
	"https://github.com/kylechui/nvim-surround",
	"https://github.com/lukas-reineke/indent-blankline.nvim",
	"https://github.com/akinsho/toggleterm.nvim",
	"https://github.com/nvim-telescope/telescope.nvim", -- fuzzy finder
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/nvim-neo-tree/neo-tree.nvim",
	"https://github.com/RRethy/vim-illuminate",
	"https://github.com/brenoprata10/nvim-highlight-colors", -- highlight hex/tailwind color strings e.g. #CCCCFF, text-sky-700
	-- "https://github.com/uga-rosa/ccc.nvim", -- color picker
	-- "https://github.com/hat0uma/csvview.nvim",
})

vim.api.nvim_create_autocmd("InsertEnter", {
	callback = function()
		print("hi")
	end,
})

-- require("nvim-treesitter.configs").setup({
-- 	-- A list of parser names, or "all"
-- 	ensure_installed = {
-- 		"css",
-- 		"typescript",
-- 		"tsx",
-- 		"astro",
-- 		"lua",
-- 		"html",
-- 		"gitignore",
-- 		"http",
-- 		"jsdoc",
-- 		"javascript",
-- 		"json",
-- 		"json5",
-- 		"markdown",
-- 		"sql",
-- 		"toml",
-- 		"yaml",
-- 		"bash",
-- 		"comment",
-- 	},
-- 	highlight = { enable = true },
-- 	indent = { enable = true },
-- })
--
-- local nvim_treesitter = require("nvim-treesitter")
-- nvim_treesitter.install({
-- 	"css",
-- 	"typescript",
-- 	"tsx",
-- 	"astro",
-- 	"lua",
-- 	"html",
-- 	"gitignore",
-- 	"http",
-- 	"jsdoc",
-- 	"javascript",
-- 	"json",
-- 	"json5",
-- 	"markdown",
-- 	"sql",
-- 	"toml",
-- 	"yaml",
-- 	"bash",
-- 	"comment",
-- })
