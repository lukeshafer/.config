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
	--  catppuccin/nvim {catppuccin}, Yazeed1s/oh-lucy.nvim {oh-lucy}, rose-pine/neovim {rose-pine}, sainnhe/everforest {everforest}
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 5000,
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
			})
			vim.cmd("color catppuccin")
		end,
	},
	{ "Yazeed1s/oh-lucy.nvim" },

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
			format_on_save = function()
				if not atWork then
					return { timeout_ms = 500, lsp_fallback = true }
				end
			end,
		},
	},

	{
		"nvim-java/nvim-java",
		config = function()
			require("java").setup()
		end,
		dependencies = {
			"nvim-java/lua-async-await",
			"nvim-java/nvim-java-refactor",
			"nvim-java/nvim-java-core",
			"nvim-java/nvim-java-test",
			"nvim-java/nvim-java-dap",
			"MunifTanjim/nui.nvim",
			"neovim/nvim-lspconfig",
			"mfussenegger/nvim-dap",
			{
				"williamboman/mason.nvim",
				opts = {
					registries = {
						"github:nvim-java/mason-registry",
						"github:mason-org/mason-registry",
					},
				},
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
			local lsp_defaults = lspconfig.util.default_config

			lsp_defaults.capabilities =
				vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

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

					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
					vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
					vim.keymap.set("n", "<leader>f", function()
						require("conform").format({ timeout_ms = 2000, bufnr = event.buf, lsp_fallback = true })
					end, opts)
				end,
			})

			vim.fn.sign_define("DiagnosticSignError", {
				texthl = "DiagnosticSignError",
				text = "✘",
				numhl = "",
			})

			vim.fn.sign_define("DiagnosticSignWarn", {
				texthl = "DiagnosticSignWarn",
				text = "▲",
				numhl = "",
			})

			vim.fn.sign_define("DiagnosticSignHint", {
				texthl = "DiagnosticSignHint",
				text = "⚑",
				numhl = "",
			})

			vim.fn.sign_define("DiagnosticSignInfo", {
				texthl = "DiagnosticSignInfo",
				text = "",
				numhl = "",
			})
		end,
	},
	{ "williamboman/mason.nvim", opts = {}, lazy = false },
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			ensure_installed = {
				"astro",
				"eslint",
				"cssls",
				"emmet_ls",
				"html",
				"jsonls",
				"lua_ls",
				"tailwindcss",
				"tsserver",
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
				tsserver = function()
					require("lspconfig").tsserver.setup({
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

	-- Autocompletion
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
				sources = {
					{ name = "path" },
					{ name = "nvim_lsp", keyword_length = 0 },
					{ name = "luasnip", keyword_length = 1 },
					{ name = "buffer", keyword_length = 3 },
				},
				mapping = cmp.mapping.preset.insert({
					-- Enter key confirms completion item
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					-- Ctrl + y confirms completion item
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					-- Ctrl + space triggers completion menu
					["<C-Space>"] = cmp.mapping.complete(),
					-- Tab and S-Tab move through completion menu
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
				}),
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
			})
		end,
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
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
		opts = {
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							if str == "NORMAL" then
								return ""
							elseif str == "INSERT" then
								return ""
							elseif str == "VISUAL" or str == "V-LINE" or str == "V-BLOCK" then
								return "󰗧"
							elseif str == "COMMAND" then
								return ""
							else
								return str
							end
						end,
					},
				},
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					{
						"filename",
						symbols = { modified = "●", readonly = "[READONLY]" },
						path = 4,
					},
				},
				lualine_x = { "encoding", "filetype" },
				lualine_y = {},
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					{
						"filename",
						symbols = { modified = "●", readonly = "[READONLY]" },
						path = 4,
					},
				},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			extensions = { "nvim-tree", "toggleterm", "man" },
		},
	}, -- status line, bottom
	{ "lewis6991/gitsigns.nvim", opts = {} }, -- inline git helpers
	{ "folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim", opts = {} }, -- highlight todo comments, e.g. TODO:
	-- { "numToStr/Comment.nvim",       opts = {},                              lazy = false },
	{ "windwp/nvim-autopairs", event = "InsertEnter", opts = {} }, -- auto-create brackets/parentheses
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		opts = {},
		config = function()
			require("nvim-ts-autotag").setup({})
		end,
	}, -- autoclose/rename html tags
	{
		"sindrets/diffview.nvim",
		event = "VeryLazy",
		dependencies = "nvim-lua/plenary.nvim",
	}, -- git diff viewer
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	}, -- tools for surrounding text
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }, -- show indentation levels

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
		-- lazy = false,
		event = "BufEnter",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		keys = {
			{
				"<leader>e",
				function()
					vim.cmd("Neotree action=focus source=filesystem position=left reveal=true")
				end,
				noremap = true,
			},
			{
				"<leader>b",
				function()
					vim.cmd("Neotree action=focus source=buffers position=left reveal=true")
				end,
				noremap = true,
			},
			{
				"<leader>g",
				function()
					vim.cmd("Neotree action=focus source=git_status position=left reveal=true")
				end,
				noremap = true,
			},
		},
		config = function()
			require("neo-tree").setup({
				-- use_default_mappings = false,
				close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
				enable_git_status = true,
				enable_diagnostics = true,
				sort_case_insensitive = true, -- used when sorting files and directories in the tree
				window = {
					position = "left",
					width = 40,
					mapping_options = {
						noremap = true,
						nowait = true,
					},
					mappings = {
						["<space>"] = {
							"toggle_node",
							nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
						},
						["<2-LeftMouse>"] = "open",
						["<cr>"] = "open",
						["<esc>"] = "cancel", -- close preview or floating neo-tree window
						["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
						["l"] = "focus_preview",
						["S"] = "open_split",
						["s"] = "open_vsplit",
						["t"] = "open_tabnew",
						["w"] = "open_with_window_picker",
						["C"] = "close_node",
						["z"] = "close_all_nodes",
						["a"] = {
							"add",
							config = {
								show_path = "none", -- "none", "relative", "absolute"
							},
						},
						["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
						["d"] = "delete",
						["r"] = "rename",
						["y"] = "copy_to_clipboard",
						["x"] = "cut_to_clipboard",
						["p"] = "paste_from_clipboard",
						["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
						["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
						["Q"] = "close_window",
						["q"] = "none",
						["R"] = "refresh",
						["?"] = "show_help",
						["<"] = "prev_source",
						[">"] = "next_source",
						["i"] = "show_file_details",
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
				nesting_rules = {},
				filesystem = {
					filtered_items = {
						visible = false, -- when true, they will just be displayed differently than normal items
						hide_dotfiles = false,
						hide_gitignored = true,
						hide_hidden = true, -- only works on Windows for hidden files/directories
					},
					window = {
						mappings = {
							["<bs>"] = "navigate_up",
							["."] = "set_root",
							["H"] = "toggle_hidden",
							["/"] = "fuzzy_finder",
							["D"] = "fuzzy_finder_directory",
							["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
							["f"] = "filter_on_submit",
							["<c-x>"] = "clear_filter",
							["[g"] = "prev_git_modified",
							["]g"] = "next_git_modified",
							["o"] = "open",
							["oc"] = "none",
							["od"] = "none",
							["og"] = "none",
							["om"] = "none",
							["on"] = "none",
							["os"] = "none",
							["ot"] = "none",
						},
						fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
							["<down>"] = "move_cursor_down",
							["<C-n>"] = "move_cursor_down",
							["<up>"] = "move_cursor_up",
							["<C-p>"] = "move_cursor_up",
							-- ['<key>'] = function(state, scroll_padding) ... end,
						},
					},

					commands = {}, -- Add a custom command or override a global one using the same function name
				},
				buffers = {
					follow_current_file = {
						enabled = true, -- This will find and focus the file in the active buffer every time
						--              -- the current file is changed while the tree is open.
						leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
					},
					group_empty_dirs = true, -- when true, empty folders will be grouped together
					show_unloaded = true,
					window = {
						mappings = {
							["d"] = "buffer_delete",
							["bd"] = "buffer_delete",
							["<bs>"] = "navigate_up",
							["."] = "set_root",
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
				},
				git_status = {
					window = {
						position = "float",
						mappings = {
							["A"] = "git_add_all",
							["gu"] = "git_unstage_file",
							["ga"] = "git_add_file",
							["gr"] = "git_revert_file",
							["gc"] = "git_commit",
							["gp"] = "git_push",
							["gg"] = "git_commit_and_push",
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
				},
			})

			vim.cmd("Neotree show")
		end,
	},

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
			local IS_WINDOWS = vim.loop.os_uname().sysname == "Windows_NT"
			if IS_WINDOWS then
				vim.g.blamer_enabled = 0
			else
				vim.g.blamer_enabled = 1
			end
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
