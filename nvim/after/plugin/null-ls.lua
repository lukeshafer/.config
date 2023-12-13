local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")
local b = null_ls.builtins

local atWork = os.getenv("PC_CONTEXT") == "work"

local lspSources = {
	--b.formatting.stylua,
	b.diagnostics.cfn_lint,
	--b.formatting.rustfmt,
	b.formatting.fixjson,
	--b.formatting.yamlfmt,
	--b.formatting.prismaFmt,
	--b.formatting.prettierd,
}

if not atWork then
	--table.insert(lspSources, b.diagnostics.eslint_d)
	--table.insert(lspSources, b.formatting.prettierd)
  table.insert(lspSources, b.formatting.prettier)
	table.insert(lspSources, b.diagnostics.eslint)
	--else
	--table.insert(
	--lspSources
	----b.formatting.prettier.with({ extra_args = { "--tab-width", "4", "--print-width", "100" } }),
	----b.formatting.prettier
	--)
end

require("null-ls").setup({
	sources = lspSources,
	-- you can reuse a shared lspconfig on_attach callback here
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			-- SPACE F to format
			vim.keymap.set("n", "<Leader>f", function()
				vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
			end, { buffer = bufnr, desc = "[lsp] format" })

			-- format on save
			--vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			--vim.api.nvim_create_autocmd("BufWritePre", {
			--group = augroup,
			--buffer = bufnr,
			--callback = function()
			--vim.lsp.buf.format({ bufnr = bufnr })
			--end,
			--})
		end
	end,
})
