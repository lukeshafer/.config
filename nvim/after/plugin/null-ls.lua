local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")
local b = null_ls.builtins

require("null-ls").setup({
	sources = {
		b.formatting.prettier.with({ extra_args = { "--tab-width", "4", "--print-width", "100" } }),
		b.formatting.stylua,
		b.diagnostics.cfn_lint,
		b.formatting.rustfmt,
		b.formatting.codespell,
		b.formatting.fixjson,
		b.formatting.npm_groovy_lint,
		b.formatting.prismaFmt,
		b.formatting.rustywind,
		--b.formatting.yamlfmt,
		--b.formatting.xmlfmt,
	},
	-- you can reuse a shared lspconfig on_attach callback here
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			-- SPACE F to format
			vim.keymap.set("n", "<Leader>f", function()
				vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
			end, { buffer = bufnr, desc = "[lsp] format" })

			-- format on save
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})
