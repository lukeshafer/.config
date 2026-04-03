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
	"nvim-lua/plenary.nvim",
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
		},
	},
	{ src = "nvim-mini/mini.hues", deps = { "nvim-mini/mini.colors" } },
	"stevearc/conform.nvim", -- Formatter management
	"williamboman/mason.nvim",
	"neovim/nvim-lspconfig",
	"rafamadriz/friendly-snippets",
	"nvim-treesitter/nvim-treesitter",
	"lewis6991/gitsigns.nvim",
	"folke/todo-comments.nvim",
	"windwp/nvim-autopairs",
	"windwp/nvim-ts-autotag",
	"sindrets/diffview.nvim",
	"kylechui/nvim-surround",
	"lukas-reineke/indent-blankline.nvim",
	"akinsho/toggleterm.nvim",
	"nvim-telescope/telescope.nvim", -- fuzzy finder
	"MunifTanjim/nui.nvim",
	"nvim-neo-tree/neo-tree.nvim",
	"RRethy/vim-illuminate",
	"brenoprata10/nvim-highlight-colors", -- highlight hex/tailwind color strings e.g. #CCCCFF, text-sky-700
	-- "https://github.com/uga-rosa/ccc.nvim", -- color picker
	-- "https://github.com/hat0uma/csvview.nvim",
})
