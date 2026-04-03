---@class PluginDef
---@field src string
---@field deps? string[]

---@param url string
local function resolve(url)
	return url:find("://") and url or "https://github.com/" .. url
end

---Light wrapper around vim.pack.add to mark dependencies
---@param plugins (PluginDef|string)[]
local function load_plugins(plugins)
	local list = {}
	for _, p in ipairs(plugins) do
		if type(p) == "string" then
			list[#list + 1] = resolve(p)
		else
			for _, dep in ipairs(p.deps or {}) do
				list[#list + 1] = resolve(dep)
			end
			list[#list + 1] = resolve(p.src)
		end
	end
	vim.pack.add(list)
end

load_plugins({
	-- "nvim-tree/nvim-web-devicons",
	"nvim-mini/mini.nvim",
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
	},
	-- { src = "nvim-mini/mini.hues", deps = { "nvim-mini/mini.colors" } },
	"stevearc/conform.nvim", -- Formatter management
	"williamboman/mason.nvim",
	"neovim/nvim-lspconfig",
	"nvim-treesitter/nvim-treesitter",
	"lewis6991/gitsigns.nvim",
	"folke/todo-comments.nvim",
	"windwp/nvim-autopairs",
	"windwp/nvim-ts-autotag",
	"sindrets/diffview.nvim",
  -- "nvim-mini/mini.nvim",
	"kylechui/nvim-surround",
	"lukas-reineke/indent-blankline.nvim",
	"akinsho/toggleterm.nvim",
	{ src = "nvim-telescope/telescope.nvim", deps = { "nvim-lua/plenary.nvim" } }, -- fuzzy finder
	{
		src = "nvim-neo-tree/neo-tree.nvim",
		deps = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
		},
	},
  -- "stevearc/oil.nvim",
	"RRethy/vim-illuminate",
	"brenoprata10/nvim-highlight-colors", -- highlight hex/tailwind color strings e.g. #CCCCFF, text-sky-700
	-- "https://github.com/uga-rosa/ccc.nvim", -- color picker
	-- "https://github.com/hat0uma/csvview.nvim",
})

local utils = require("lksh.utils")

if not vim.version.range(">=0.12.0"):has(vim.version()) then
	return
end

require("mason").setup({})
require("gitsigns").setup({})
require("todo-comments").setup({})
require("nvim-autopairs").setup({})
require("nvim-autopairs").setup({})
require("nvim-ts-autotag").setup({})
require("nvim-surround").setup({})
require("illuminate").configure({})

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

vim.keymap.set("n", "<leader>vo", "<cmd>DiffviewOpen<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>vc", "<cmd>DiffviewClose<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>vm", "<cmd>DiffviewOpen origin/main<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>vd", "<cmd>DiffviewOpen origin/dev<cr>", { noremap = true, silent = true })

local seed = utils.get_seed_from_string(vim.fn.getcwd())
require("lksh.colors").prepare_color_theme(seed)

local miniFiles = require("mini.files")
miniFiles.setup({})
vim.keymap.set("n", "<leader>e", function()
	miniFiles.open()
end, { noremap = true, silent = true })

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

require("nvim-highlight-colors").setup({
	render = "background", -- 'foreground' or 'background' or 'virtual'
	enable_named_colors = false,
	enable_tailwind = true, -- bg-blue-450
})

local nvim_treesitter = require("nvim-treesitter")
nvim_treesitter.install({
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
		nvim_treesitter.update()
	end,
})

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

require("toggleterm").setup({ direction = "horizontal" })
vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<cr>", { noremap = true, silent = true })
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
vim.keymap.set("t", "<C-h>", "<cmd>wincmd h<cr>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-j>", "<cmd>wincmd j<cr>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-k>", "<cmd>wincmd k<cr>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-l>", "<cmd>wincmd l<cr>", { noremap = true, silent = true })
