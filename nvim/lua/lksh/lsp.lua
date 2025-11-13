vim.lsp.enable({
	"html",
	"jsonls",
	"lua_ls",
	"ts_ls",
	"yamlls",
})

if os.getenv("PC_CONTEXT") == "work" then
	-- ONLY NEED FOR WORK
  -- nothing
else
	-- NOT NEEDED AT WORK
	vim.lsp.enable({
		"astro",
		"cssls",
		"emmet_ls",
		"tailwindcss",
	})
end

if os.getenv("PC_CONTEXT") == "desktop-wsl" then
	vim.lsp.config.gdscript = { cmd = { "godot-wsl-lsp" } }
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local opts = { noremap = true, silent = true, buffer = ev.buf }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	end,
})

-- vim.diagnostic.config()
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "✘",
			[vim.diagnostic.severity.WARN] = "▲",
			[vim.diagnostic.severity.HINT] = "⚑",
			[vim.diagnostic.severity.INFO] = "",
		},
		linehl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
		},
		numhl = {
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
		texthl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
			[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
			[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
		},
	},
})
