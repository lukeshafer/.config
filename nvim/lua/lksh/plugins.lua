-- Add another property to PluginDef to automatically setup packages
--  { setup = true } -- call require(plugin_name).setup({})
--  { setup = some_table } -- call require(plugin_name).setup(some_table)
--  plugin_name should resolve to the last portion of the source, minus any .nvim suffix. For instance, "stevarc/conform.nvim" should resolve to "conform" and call `require("conform")`
--  { setup = function() ... end } -- call the passed function instead of a require().setup
--

---@class PluginDef
---@field src string
---@field deps? string[]
---@field setup? boolean|table|function

---@param url string
local function resolve(url)
	return url:find("://") and url or "https://github.com/" .. url
end

local function plugin_name(src)
	return src:match("[^/]+$"):gsub("%.nvim$", "")
end

---Light wrapper around vim.pack.add to mark dependencies
---@param plugins (PluginDef|string)[]
local function load_plugins(plugins)
	local list = {}
	local setups = {}
	for _, p in ipairs(plugins) do
		if type(p) == "string" then
			list[#list + 1] = resolve(p)
		else
			for _, dep in ipairs(p.deps or {}) do
				list[#list + 1] = resolve(dep)
			end
			list[#list + 1] = resolve(p.src)
			if p.setup then
				setups[#setups + 1] = { src = p.src, setup = p.setup }
			end
		end
	end
	vim.pack.add(list)
	for _, s in ipairs(setups) do
		if type(s.setup) == "function" then
			s.setup()
		else
			local opts = s.setup == true and {} or s.setup
			require(plugin_name(s.src)).setup(opts)
		end
	end
end

load_plugins({
	"nvim-tree/nvim-web-devicons",
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
	{ src = "nvim-mini/mini.hues", deps = { "nvim-mini/mini.colors" } },
	"stevearc/conform.nvim", -- Formatter management
	"williamboman/mason.nvim",
	"neovim/nvim-lspconfig",
	"nvim-treesitter/nvim-treesitter",
	"lewis6991/gitsigns.nvim",
	"folke/todo-comments.nvim",
	"windwp/nvim-autopairs",
	"windwp/nvim-ts-autotag",
	"sindrets/diffview.nvim",
	"kylechui/nvim-surround",
	{
		src = "lukas-reineke/indent-blankline.nvim",
		setup = function()
			require("ibl").setup({})
		end,
	},
	"akinsho/toggleterm.nvim",
	{ src = "nvim-telescope/telescope.nvim", deps = { "nvim-lua/plenary.nvim" } }, -- fuzzy finder
	{
		src = "nvim-neo-tree/neo-tree.nvim",
		deps = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
		},
	},
	"RRethy/vim-illuminate",
	"brenoprata10/nvim-highlight-colors", -- highlight hex/tailwind color strings e.g. #CCCCFF, text-sky-700
	-- "https://github.com/uga-rosa/ccc.nvim", -- color picker
	-- "https://github.com/hat0uma/csvview.nvim",
})
