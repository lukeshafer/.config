local utils = require("lksh.utils")

---@class PluginDef
---@field src string
---@field deps? string[]
---@field setup? boolean|table|function

---@param url string
local function resolve_plugin_url(url)
	return url:find("://") and url or "https://github.com/" .. url
end

---@param name string
---@return string
local function resolve_plugin_module(name)
	local m = name:match("[^/]+$"):gsub("%.nvim$", "")
	return m
end

---Light wrapper around vim.pack.add to mark dependencies
---@param plugins (PluginDef|string)[]
local function load_plugins(plugins)
	---@type string[]
	local plugin_list = {}
	---@type function[]
	local setup_fns = {}
	for _, p in ipairs(plugins) do
		if type(p) == "string" then
			table.insert(plugin_list, resolve_plugin_url(p))
		else
			for _, dep in ipairs(p.deps or {}) do
				table.insert(plugin_list, resolve_plugin_url(dep))
			end
			table.insert(plugin_list, resolve_plugin_url(p.src))
			local setup = p.setup
			if type(setup) == "function" then
				table.insert(setup_fns, setup)
			elseif setup == true then
				table.insert(setup_fns, function()
					require(resolve_plugin_module(p.src)).setup({})
				end)
			elseif type(setup) == "table" then
				table.insert(setup_fns, function()
					require(resolve_plugin_module(p.src)).setup(setup)
				end)
			end
		end
	end

	vim.pack.add(plugin_list)

	for _, setup_fn in ipairs(setup_fns) do
		setup_fn()
	end
end

load_plugins({
	-- "nvim-tree/nvim-web-devicons",
	{
		src = "nvim-mini/mini.nvim",
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

			local seed = utils.get_seed_from_string(vim.fn.getcwd())
			require("lksh.colors").prepare_color_theme(seed)
		end,
	},
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
	{ src = "lewis6991/gitsigns.nvim", setup = true },
	{ src = "folke/todo-comments.nvim", setup = true },
	{ src = "windwp/nvim-autopairs", setup = true },
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
	{ src = "kylechui/nvim-surround", setup = true },
	"lukas-reineke/indent-blankline.nvim",
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
		src = "nvim-telescope/telescope.nvim",
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
	-- {
	-- 	src = "nvim-neo-tree/neo-tree.nvim",
	-- 	deps = {
	-- 		"MunifTanjim/nui.nvim",
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- },
	{
		src = "RRethy/vim-illuminate",
		setup = function()
			require("illuminate").configure({})
		end,
	},
	{
		src = "brenoprata10/nvim-highlight-colors",
		setup = {
			render = "background", -- 'foreground' or 'background' or 'virtual'
			enable_named_colors = false,
			enable_tailwind = true, -- bg-blue-400
		},
	},
	-- "https://github.com/uga-rosa/ccc.nvim", -- color picker
	-- "https://github.com/hat0uma/csvview.nvim",
})

if not vim.version.range(">=0.12.0"):has(vim.version()) then
	return
end

-- require("neo-tree").setup({
-- 	sort_case_insensitive = true,
-- 	window = {
-- 		position = "float",
-- 		mappings = {
-- 			["o"] = "open",
-- 			["oc"] = "none",
-- 			["od"] = "none",
-- 			["og"] = "none",
-- 			["om"] = "none",
-- 			["on"] = "none",
-- 			["os"] = "none",
-- 			["ot"] = "none",
-- 		},
-- 	},
-- 	filesystem = {
-- 		filtered_items = {
-- 			visible = false, -- when true, they will just be displayed differently than normal items
-- 			hide_dotfiles = false,
-- 			hide_gitignored = true,
-- 			hide_hidden = true, -- only works on Windows for hidden files/directories
-- 		},
-- 	},
-- })
--
-- vim.keymap.set("n", "<leader>e", "<Cmd>Neotree reveal<cr>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<leader>b", "<cmd>Neotree buffers reveal<cr>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<leader>g", "<cmd>Neotree git_status reveal<cr>", { noremap = true, silent = true })
