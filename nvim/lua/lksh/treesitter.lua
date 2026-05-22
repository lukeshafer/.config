local TS = {}

function TS.highlight(bufnr, lang)
	if not vim.treesitter.language.add(lang) then
		return vim.notify(
			string.format("Treesitter cannot load parser for language: %s", lang),
			vim.log.levels.INFO,
			{ title = "Treesitter" }
		)
	end
	vim.treesitter.start(bufnr, lang)
end

function TS.init()
	vim.api.nvim_create_autocmd("FileType", {
		callback = function(args)
			if vim.bo.buftype ~= "" then
				return
			end

			local ft = vim.bo.filetype
			local ts = require("lksh.ts-parsers")

			vim.opt_local.foldmethod = "expr"
			vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.opt_local.foldlevel = 1

			if not vim.tbl_contains({ "python", "html", "yaml", "markdown" }, ft) then
				vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
			end

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

			if vim.list_contains(ts.get_installed(), ft) then
				TS.highlight(args.buf, ft)
			elseif vim.list_contains(ts.get_available(), ft) then
				ts.install(ft, function()
					TS.highlight(args.buf, ft)
				end)
			end
		end,
	})

	-- require("lksh.ts-parsers").create_commands()
end

return TS
