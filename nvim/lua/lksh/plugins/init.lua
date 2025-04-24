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
	-- { "catppuccin/nvim", name = "catppuccin" },
	-- { "Yazeed1s/oh-lucy.nvim" },
	-- { "bluz71/vim-moonfly-colors" },
	-- { "mellow-theme/mellow.nvim" },
	-- { "slugbyte/lackluster.nvim" },
	-- { "rose-pine/neovim", name = "rose-pine" },

	require("lksh.plugins.color"),
	require("lksh.plugins.conform-nvim"),
	require("lksh.plugins.nvim-lspconfig"),
	{ "williamboman/mason.nvim", opts = {}, lazy = false },
	require("lksh.plugins.mason-lspconfig"),

	-- Autocompletion
	require("lksh.plugins.nvim-cmp"),
	-- { "hrsh7th/cmp-nvim-lsp" },
	-- { "hrsh7th/cmp-buffer" },
	-- { "hrsh7th/cmp-path" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "hrsh7th/cmp-nvim-lua" },

	-- Snippets
	{ "L3MON4D3/LuaSnip" },
	{ "rafamadriz/friendly-snippets" },

	require("lksh.plugins.nvim-treesitter"),

	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- require("lksh.plugins.lualine"),

	{ "lewis6991/gitsigns.nvim", opts = {} }, -- inline git helpers
	{ "folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim", opts = {} },
	{ "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
	{ "windwp/nvim-ts-autotag", event = "InsertEnter", opts = {} },
	{
		"sindrets/diffview.nvim", -- git diff viewer
		event = "VeryLazy",
		dependencies = "nvim-lua/plenary.nvim",
		keys = {
			{ "<leader>vo", ":DiffviewOpen<cr>" },
			{ "<leader>vc", ":DiffviewClose<cr>" },
			{ "<leader>vm", ":DiffviewOpen origin/main<cr>" },
			{ "<leader>vd", ":DiffviewOpen origin/dev<cr>" },
		},
	},

	{ "kylechui/nvim-surround", version = "*", event = "VeryLazy", opts = {} },
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

	require("lksh.plugins.toggleterm"),
	require("lksh.plugins.telescope"),
	require("lksh.plugins.neo-tree"),

	{
		"RRethy/vim-illuminate",
		event = "VeryLazy",
		config = function()
			require("illuminate").configure({})
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
		"hat0uma/csvview.nvim",
		opts = {
			parser = { comments = { "#", "//" } },
			keymaps = {
				-- Text objects for selecting fields
				textobject_field_inner = { "if", mode = { "o", "x" } },
				textobject_field_outer = { "af", mode = { "o", "x" } },
				jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
				jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
				jump_next_row = { "<Enter>", mode = { "n", "v" } },
				jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
			},
		},
		cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
		keys = {
			{ "<leader>cs", "<cmd>CsvViewToggle<cr>" },
		},
	},
}

require("lazy").setup(plugins)
