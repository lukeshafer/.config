if not vim.version.range(">=0.12.0"):has(vim.version()) then
	vim.notify("Neovim plugins require version 0.12.0 or later.", vim.log.levels.ERROR)
	return
end

local function resolve_plug(url)
	return url:find("://") and url or "https://github.com/" .. url
end

local Plugins = {}

function Plugins.clean_inactive()
  ---@type vim.pack.PlugData[]
  local inactive = vim.tbl_filter(function (p)
    return not p.active
  end, vim.pack.get(nil, {info=false}))

  if #inactive > 0 then
    vim.pack.del(inactive)
  end
end

function Plugins.init()
	vim.pack.add({
		resolve_plug("stevearc/oil.nvim"),
		resolve_plug("nvim-mini/mini.nvim"),
		resolve_plug("neovim/nvim-lspconfig"),
		resolve_plug("OXY2DEV/markview.nvim"),
		resolve_plug("stevearc/conform.nvim"),
		resolve_plug("mfussenegger/nvim-lint"),
		resolve_plug("windwp/nvim-ts-autotag"),
		resolve_plug("williamboman/mason.nvim"),
		resolve_plug("carlos-algms/agentic.nvim"),
		resolve_plug("nvim-treesitter/nvim-treesitter"),
		resolve_plug("refractalize/oil-git-status.nvim"),
		resolve_plug("nvim-treesitter/nvim-treesitter-context"),
		-- utils.plugin("nvim-treesitter/nvim-treesitter-textobjects"),
	})

  -- Removed plugins I may miss
  -- "https://github.com/uga-rosa/ccc.nvim", -- color picker
  -- "https://github.com/hat0uma/csvview.nvim",
end

return Plugins
