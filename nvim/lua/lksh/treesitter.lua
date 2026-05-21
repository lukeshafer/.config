local Treesitter = {}

---@class TreeSitterParser
---@field url string
---@field branch string?

---@type table<string, TreeSitterParser?>
local parser_info = {
	javascript = {
		url = "https://github.com/tree-sitter/tree-sitter-javascript",
	},
	typescript = {
		url = "https://github.com/tree-sitter/tree-sitter-typescript",
	},
}

parser_info.tsx = parser_info.typescript

local function highlight(bufnr, lang)
	if not vim.treesitter.language.add(lang) then
		return vim.notify(
			string.format("Treesitter cannot load parser for language: %s", lang),
			vim.log.levels.INFO,
			{ title = "Treesitter" }
		)
	end
	vim.treesitter.start(bufnr, lang)
end

function Treesitter.init()
	vim.api.nvim_create_autocmd("FileType", {
		callback = function(args)
			if vim.bo.buftype ~= "" then
				return
			end

			local ft = vim.bo.filetype
			local ts_parsers = require("lksh.ts-parsers")

			-- vim.opt_local.foldmethod = "expr"
			-- vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			-- vim.opt_local.foldlevel = 1

			-- if not vim.tbl_contains({ "python", "html", "yaml", "markdown" }, ft) then
			-- 	vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
			-- end

			if vim.fn.executable("tree-sitter") ~= 1 then
				vim.notify(
					"tree-sitter CLI not found. Parsers cannot be installed. \nInstall tree-sitter-cli with your package manager.",
					vim.log.levels.ERROR,
					{ title = "TreeSitter" }
				)
				return false
			end

			if ft == "p8" then
				ft = "lua"
			end

			if not vim.treesitter.language.get_lang(ft) then
				return
			end

			if vim.list_contains(ts_parsers.get_installed(), ft) then
				highlight(args.buf, ft)
			elseif vim.list_contains(ts_parsers.get_available(), ft) then
				ts_parsers.install(ft, function()
					highlight(args.buf, ft)
				end)
			end
		end,
	})

  require("lksh.ts-parsers").create_commands()
end

return Treesitter
