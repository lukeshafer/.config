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

local utils = require('lksh.utils')

-- actual lazy configuration
local plugins = {
	-- colors i like
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	-- config = color("catppuccin"),
	-- },
	-- {
	-- 	"Yazeed1s/oh-lucy.nvim",
	-- 	-- config = color("oh-lucy"),
	-- },
	-- {
	-- 	"bluz71/vim-moonfly-colors",
	-- 	-- config = color("moonfly")
	-- },
	-- {
	-- 	"mellow-theme/mellow.nvim",
	-- 	-- config = color("mellow"),
	-- },
	-- {
	-- 	"slugbyte/lackluster.nvim",
	-- 	-- config = color("lackluster"),
	-- },
	-- {
	-- 	"rose-pine/neovim",
	-- 	name = "rose-pine",
	-- 	-- config = color("rose-pine"),
	-- },
{
	"echasnovski/mini.hues",
	dependencies = { "echasnovski/mini.colors" },
	version = false,
	lazy = false,
	config = function()
		-- Generate random config with initialized random seed based on cwd
		local seed = utils.get_seed_from_string(vim.fn.getcwd())
		vim.g.lksh_color_seed = seed
		math.randomseed(seed)
		local base_colors = utils.gen_random_base_colors()

		vim.g.lksh_background = base_colors.background
		vim.g.lksh_foreground = base_colors.foreground

		require("mini.hues").setup({
			background = base_colors.background,
			foreground = base_colors.foreground,
			n_hues = 8,
			saturation = vim.o.background == "dark" and "medium" or "high",
			accent = "fg",
		})

		vim.g.colors_name = "randomhue"
	end,
},

	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				sources = cmp.config.sources({
					{ name = "nvim_lsp", keyword_length = 0 },
					{ name = "luasnip", keyword_length = 1 },
				}, {
					{ name = "path" },
					{ name = "buffer", keyword_length = 3 },
				}),
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ select = false }), -- Enter key confirms completion item
					["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Ctrl + y confirms completion item
					["<C-Space>"] = cmp.mapping.complete(), -- Ctrl + space triggers completion menu
					["<Tab>"] = cmp.mapping.select_next_item(), -- Tab and S-Tab move through completion menu
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
				}),
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
			})
		end,
	},

	{
		"stevearc/conform.nvim", -- Formatter management
		lazy = true,
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ timeout_ms = 2000, lsp_fallback = true })
				end,
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = utils.js_formatter,
				typescript = utils.js_formatter,
				javascriptreact = utils.js_formatter,
				typescriptreact = utils.js_formatter,
				jsx = utils.js_formatter,
				tsx = utils.js_formatter,
				astro = utils.js_formatter,
				json = { "fixjson" },
				java = { "google-java-format" },
				go = { "golines", "goimports", "gofumpt" },
				soql = { "sleek" },
			},
		},
	},

	{ "williamboman/mason.nvim", opts = {}, lazy = false },
	{ "neovim/nvim-lspconfig", event = { "BufReadPost", "BufNewFile" } },

	-- Autocompletion
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "hrsh7th/cmp-nvim-lua" },

	-- Snippets
	{ "L3MON4D3/LuaSnip" },
	{ "rafamadriz/friendly-snippets" },

	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufEnter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				-- A list of parser names, or "all"
				ensure_installed = {
					"css",
					"typescript",
					"tsx",
					"astro",
					"lua",
					"html",
					"gitignore",
					"http",
					"jsdoc",
					"javascript",
					"json",
					"json5",
					"markdown",
					"sql",
					"toml",
					"yaml",
					"bash",
					"comment",
				},
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},

	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- require("lksh.plugins.lualine"),

	{ "lewis6991/gitsigns.nvim", opts = {} }, -- inline git helpers
	{ "nvim-lua/plenary.nvim" },
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

	{
		"akinsho/toggleterm.nvim",
		keys = {
			{ "<leader>t", "<cmd>ToggleTerm<cr>" },
			{ "<esc>", [[<C-\><C-n>]], mode = "t", buffer = 0 },
			{ "<C-h>", "<cmd>wincmd h<cr>", mode = "t", buffer = 0 },
			{ "<C-j>", "<cmd>wincmd j<cr>", mode = "t", buffer = 0 },
			{ "<C-k>", "<cmd>wincmd k<cr>", mode = "t", buffer = 0 },
			{ "<C-l>", "<cmd>wincmd l<cr>", mode = "t", buffer = 0 },
		},
		event = "TermOpen",
		opts = { direction = "horizontal" },
		config = function()
			require("toggleterm").setup({ direction = "horizontal" })
		end,
	},

	{
		"nvim-telescope/telescope.nvim", -- fuzzy finder
		lazy = true,
		config = {
			defaults = { file_ignore_patterns = { "node_modules", "dist", "build", ".git" } },
			pickers = { find_files = { hidden = true } },
		},
		keys = {
			{
				"ff",
				function()
					require("telescope.builtin").find_files()
				end,
			},
			{
				"fg",
				function()
					require("telescope.builtin").live_grep()
				end,
			},
			{
				"fb",
				function()
					require("telescope.builtin").buffers()
				end,
			},
			{
				"fh",
				function()
					require("telescope.builtin").help_tags()
				end,
			},
		},
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		-- event = "BufEnter",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		cmd = { "Neotree" },
		keys = {
			{ "<leader>e", ":Neotree reveal<cr>", noremap = true },
			{ "<leader>b", ":Neotree buffers reveal<cr>", noremap = true },
			{ "<leader>g", ":Neotree git_status reveal<cr>", noremap = true },
		},
		config = function()
			require("neo-tree").setup({
				sort_case_insensitive = true,
				window = {
					position = "float",
					mappings = {
						["o"] = "open",
						["oc"] = "none",
						["od"] = "none",
						["og"] = "none",
						["om"] = "none",
						["on"] = "none",
						["os"] = "none",
						["ot"] = "none",
					},
				},
				filesystem = {
					filtered_items = {
						visible = false, -- when true, they will just be displayed differently than normal items
						hide_dotfiles = false,
						hide_gitignored = true,
						hide_hidden = true, -- only works on Windows for hidden files/directories
					},
				},
			})
		end,
	},

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
