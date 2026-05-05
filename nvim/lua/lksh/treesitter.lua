local M = {}

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

---@param filetype string
function M.install(filetype)
	-- get parser url
	-- git clone to location
	--    vim.api.stdpath('data').."/tree-sitter-repos"..repo-name
	-- in the repo run cli commands
	--    tree-sitter generate
	--    tree-sitter build
	-- identify parser, either *.so or *.dylib (depending on OS)
	-- then move to location
	--    vim.api.stdpath('data').."/site/parser/"
	-- can copy scm queries from repo
	--  or use the ones in nvim-treesiter repo for the time being
	--    vim.api.stdpath('data').."/site/queries/"..lang

	local info = parser_info[filetype]
	if info == nil then
		return
	end

	local data_path = vim.fn.stdpath("data")
	local ts_repo_path = data_path .. "/tree-sitter-repos"

	vim.system({ "mkdir", "-p", ts_repo_path }):wait()

	vim.system({ "git", "clone", info.url }, {
		cwd = ts_repo_path,
	}):wait()
end

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

function M.init()
	vim.api.nvim_create_autocmd("FileType", {
		callback = function(args)
			if vim.bo.buftype ~= "" then
				return
			end

			local ft = vim.bo.filetype
			local treesitter = require("nvim-treesitter")

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

			if not vim.treesitter.language.get_lang(ft) then
				return
			end

			if vim.list_contains(treesitter.get_installed(), ft) then
				highlight(args.buf, ft)
			elseif vim.list_contains(treesitter.get_available(), ft) then
				treesitter.install(ft):await(function()
					highlight(args.buf, ft)
				end)
			end
		end,
	})
end

LukeTS = M
return M
