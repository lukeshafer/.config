local utils = require("lksh.utils")

if not vim.version.range(">=0.12.0"):has(vim.version()) then
	return
end

utils.load_plugins({
	utils.mini_nvim_modules({
		"colors",
		"cursorword",
		"git",
		"icons",
		"pairs",
		"surround",
		{
			"files",
			setup = function()
				require("mini.files").setup({
					mappings = {
						go_in = "L", -- swap go in plus to close explorer by default
						go_in_plus = "l",
					},
				})

				vim.keymap.set("n", "<leader>e", function()
					MiniFiles.open()
				end, { noremap = true, silent = true })

				vim.keymap.set("n", "<leader>E", function()
					MiniFiles.open(vim.api.nvim_buf_get_name(0))
				end, { noremap = true, silent = true })
			end,
		},
		{
			"hues",
			setup = function()
				math.randomseed(utils.get_seed_from_string(vim.fn.getcwd()))

				require("mini.hues").setup({
					background = require("mini.colors").convert({
						l = vim.o.background == "dark" and 12 or 85,
						c = 3,
						h = math.random(180, 360),
					}, "hex"),
					foreground = require("mini.colors").convert({
						l = vim.o.background == "dark" and 87 or 10,
						c = 2,
						h = math.random(0, 360),
					}, "hex"),
					n_hues = 8,
					saturation = vim.o.background == "dark" and "medium" or "high",
					accent = "fg",
				})

				vim.g.colors_name = "randomhue"
			end,
		},
		{
			"indentscope",
			setup = function()
				require("mini.indentscope").setup({
					draw = {
						delay = 0,
						animation = require("mini.indentscope").gen_animation.none(),
					},
					options = { indent_at_cursor = true },
					symbol = "▎",
				})
			end,
		},
		{
			"diff",
			setup = function()
				require("mini.diff").setup({
					view = {
						style = "sign",
						signs = {
							-- add = "",
							add = "▎",
							change = "▎",
							delete = "▁",
						},
					},
				})

				vim.api.nvim_set_hl(0, "MiniDiffSignChange", {
					link = "diffFile",
				})
			end,
		},
	}),
	{
		src = "hrsh7th/nvim-cmp",
		deps = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			"hrsh7th/cmp-nvim-lua",
			-- "rafamadriz/friendly-snippets",
		},
		setup = function()
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
		src = "stevearc/conform.nvim",
		setup = function()
			local conform = require("conform")

			conform.setup({
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
					-- java = { "google-java-format" },
					-- go = { "golines", "goimports", "gofumpt" },
					soql = { "sleek" },
				},
			})

			vim.keymap.set("n", "<leader>f", function()
				conform.format({ timeout_ms = 2000, lsp_fallback = true })
			end, { noremap = true, silent = true })
		end,
	}, -- Formatter management
	{ src = "williamboman/mason.nvim", setup = true },
	"neovim/nvim-lspconfig",
	{
		src = "nvim-treesitter/nvim-treesitter",
		setup = function()
			require("nvim-treesitter").install({
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
			})

			vim.api.nvim_create_autocmd("PackChanged", {
				callback = function()
					require("nvim-treesitter").update()
				end,
			})
		end,
	},
	{ src = "windwp/nvim-ts-autotag", setup = true },
	{
		src = "sindrets/diffview.nvim",
		setup = function()
			vim.keymap.set("n", "<leader>vo", "<cmd>DiffviewOpen<cr>", { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>vc", "<cmd>DiffviewClose<cr>", { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>vm", "<cmd>DiffviewOpen origin/main<cr>", { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>vd", "<cmd>DiffviewOpen origin/dev<cr>", { noremap = true, silent = true })
		end,
	},
	{
		src = "akinsho/toggleterm.nvim",
		setup = function()
			require("toggleterm").setup({ direction = "horizontal" })
			vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<cr>", { noremap = true, silent = true })
			vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
			vim.keymap.set("t", "<C-h>", "<cmd>wincmd h<cr>", { noremap = true, silent = true })
			vim.keymap.set("t", "<C-j>", "<cmd>wincmd j<cr>", { noremap = true, silent = true })
			vim.keymap.set("t", "<C-k>", "<cmd>wincmd k<cr>", { noremap = true, silent = true })
			vim.keymap.set("t", "<C-l>", "<cmd>wincmd l<cr>", { noremap = true, silent = true })
		end,
	},
	{
		src = "nvim-telescope/telescope.nvim", -- mini.pick may be able to replace (see mini.extra too)
		deps = { "nvim-lua/plenary.nvim" },
		setup = function()
			require("telescope").setup({
				defaults = { file_ignore_patterns = { "node_modules", "dist", "build" } },
				pickers = { find_files = { hidden = true } },
			})

			vim.keymap.set("n", "ff", function()
				require("telescope.builtin").find_files()
			end, { noremap = true, silent = true })
			vim.keymap.set("n", "fg", function()
				require("telescope.builtin").live_grep()
			end, { noremap = true, silent = true })
			vim.keymap.set("n", "fb", function()
				require("telescope.builtin").buffers()
			end, { noremap = true, silent = true })
			vim.keymap.set("n", "fh", function()
				require("telescope.builtin").help_tags()
			end, { noremap = true, silent = true })
		end,
	}, -- fuzzy finder
	{
		src = "brenoprata10/nvim-highlight-colors", -- mini.hipatterns may be able to replace
		setup = {
			render = "background", -- 'foreground' or 'background' or 'virtual'
			enable_named_colors = false,
			enable_tailwind = true, -- bg-blue-400
		},
	},
	-- "https://github.com/uga-rosa/ccc.nvim", -- color picker
	-- "https://github.com/hat0uma/csvview.nvim",
})

