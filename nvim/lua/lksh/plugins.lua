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

local atWork = os.getenv("PC_CONTEXT") == "work"
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

local function js_formatter()
	if atWork then
		return {}
	end

	return { "prettier" }
end

-- actual lazy configuration
local plugins = {
	-- colors i like
	-- { "catppuccin/nvim", name = "catppuccin" },
	-- { "Yazeed1s/oh-lucy.nvim" },
	-- { "bluz71/vim-moonfly-colors" },
	-- { "mellow-theme/mellow.nvim" },
	-- { "slugbyte/lackluster.nvim" },
	-- { "rose-pine/neovim", name = "rose-pine" },

	------------------
	--     MINI     --
	------------------
	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			vim.cmd("colorscheme randomhue")

			require("mini.files").setup()
			vim.keymap.set("n", "<leader>e", MiniFiles.open, {})

			-- local starter = require("mini.starter")
			-- starter.setup({
			-- 	items = {
			-- 		{ name = "FE : Explore Files", action = MiniFiles.open, section = "Files" },
			-- 		starter.sections.recent_files(10, true),
			-- 		starter.sections.pick(),
			-- 	},
			-- })

			require("mini.icons").setup()
			require("mini.statusline").setup()
			require("mini.pairs").setup()
			require("mini.surround").setup()
			require("mini.cursorword").setup()
			require("mini.completion").setup()
			require("mini.snippets").setup()

			require("mini.pick").setup()

			vim.keymap.set("n", "ff", ":Pick files<cr>", {})
			vim.keymap.set("n", "fg", ":Pick grep_live<cr>", {})
			vim.keymap.set("n", "fh", ":Pick help<cr>", {})
			vim.keymap.set("n", "fb", ":Pick buffers<cr>", {})

			require("mini.diff").setup({
				view = {
					signs = { add = "┃", change = "┃", delete = "┃" },
				},
			})

			local indentscope = require("mini.indentscope")
			indentscope.setup({
				draw = {
					animation = indentscope.gen_animation.none(),
				},
			})

			local hi = require("mini.hipatterns")
			hi.setup({
				highlighters = {
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

					hex_color = hi.gen_highlighter.hex_color(),
				},
			})
		end,
	},

	------------------
	--      LSP     --
	------------------
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
				javascript = js_formatter,
				typescript = js_formatter,
				javascriptreact = js_formatter,
				typescriptreact = js_formatter,
				jsx = js_formatter,
				tsx = js_formatter,
				astro = js_formatter,
				json = { "fixjson" },
				java = { "google-java-format" },
			},
		},
	},

	-- LSP Support
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
		config = function()
			local lspconfig = require("lspconfig")
			local onWSL = os.getenv("PC_CONTEXT") == "desktop-wsl"

			if onWSL then
				lspconfig.gdscript.setup({
					cmd = { "godot-wsl-lsp" },
				})
			else
				lspconfig.gdscript.setup({})
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { noremap = true, silent = true, buffer = event.buf }

					vim.keymap.set("n", "<leader>f", function()
						require("conform").format({ timeout_ms = 2000, bufnr = event.buf, lsp_fallback = true })
					end, opts)
				end,
			})
		end,
	},
	{ "williamboman/mason.nvim", opts = {}, lazy = false },
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			ensure_installed = {
				-- "astro",
				-- "eslint",
				"cssls",
				"emmet_ls",
				"html",
				"jsonls",
				"lua_ls",
				-- "tailwindcss",
				"ts_ls",
			},
			handlers = {
				function(server)
					require("lspconfig")[server].setup({})
				end,
				lua_ls = function()
					require("lspconfig").lua_ls.setup({
						settings = {
							Lua = {
								runtime = { version = "LuaJIT" },
								diagnostics = { globals = { "vim" } },
								workspace = { library = { vim.env.VIMRUNTIME } },
							},
						},
					})
				end,
				ts_ls = function()
					require("lspconfig").ts_ls.setup({
						init_options = { preferences = { disableSuggestions = true } },
					})
				end,
				yamlls = function()
					require("lspconfig").yamlls.setup({
						settings = {
							yaml = {
								customTags = {
									"!Equals sequence",
									"!FindInMap sequence",
									"!GetAtt",
									"!GetAZs",
									"!ImportValue",
									"!Join sequence",
									"!Ref",
									"!Select sequence",
									"!Split sequence",
									"!Sub",
									"!If sequence",
									"!Not sequence",
									"!Or sequence",
								},
							},
						},
					})
				end,
				jsonls = function()
					require("lspconfig").jsonls.setup({
						settings = {
							json = {
								schemas = {
									{
										fileMatch = { "package.json" },
										url = "https://json.schemastore.org/package.json",
									},
									{
										fileMatch = { "jsconfig*.json" },
										url = "https://json.schemastore.org/jsconfig.json",
									},
									{
										fileMatch = { "tsconfig*.json" },
										url = "https://json.schemastore.org/tsconfig.json",
									},
									{
										fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
										url = "https://json.schemastore.org/prettierrc.json",
									},
									{
										fileMatch = { ".eslintrc", ".eslintrc.json" },
										url = "https://json.schemastore.org/eslintrc.json",
									},
									{
										fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" },
										url = "https://json.schemastore.org/babelrc.json",
									},
									{
										fileMatch = {
											".stylelintrc",
											".stylelintrc.json",
											"stylelint.config.json",
										},
										url = "http://json.schemastore.org/stylelintrc.json",
									},
								},
							},
						},
					})
				end,
				tailwindcss = function()
					require("lspconfig").tailwindcss.setup({
						settings = {
							tailwindCSS = {
								classAttributes = {
									"class",
									"className",
									"class:list",
									"classList",
									"ngClass",
									".*Styles.*",
								},
								experimental = { classRegex = { { "/\\*tw\\*/ ([^;]*);", "'([^']*)'" } } },
							},
						},
					})
				end,
			},
		},
	},

	------------------
	--    OTHER     --
	------------------

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

	{
		"windwp/nvim-ts-autotag", -- autoclose/rename html tags
		event = "InsertEnter",
		opts = {},
		config = function()
			require("nvim-ts-autotag").setup({})
		end,
	},
	{
		"sindrets/diffview.nvim", -- git diff viewer
		event = "VeryLazy",
		dependencies = "nvim-lua/plenary.nvim",
		keys = {
			{ "<leader>vo", "<cmd>DiffviewOpen<cr>" },
			{ "<leader>vc", "<cmd>DiffviewClose<cr>" },
			{ "<leader>vm", "<cmd>DiffviewOpen origin/main<cr>" },
			{ "<leader>vd", "<cmd>DiffviewOpen origin/dev<cr>" },
		},
	},

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
	}, -- Terminal pane/tab/window handler

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
				-- Excel-like navigation:
				-- Use <Tab> and <S-Tab> to move horizontally between fields.
				-- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
				-- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
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
