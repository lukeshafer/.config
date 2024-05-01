local lspconfig = require("lspconfig")
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities =
	vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

local onWSL = os.getenv("PC_CONTEXT") == "desktop-wsl"

if onWSL then
	lspconfig.gdscript.setup({
		cmd = { "godot-wsl-lsp" },
	})
else
	lspconfig.gdscript.setup({})
end

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local opts = { noremap = true, silent = true, buffer = event.buf }

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "<leader>f", function()
			require("conform").format({ timeout_ms = 2000, bufnr = event.buf, lsp_fallback = true })
		end, opts)
	end,
})

vim.fn.sign_define("DiagnosticSignError", {
	texthl = "DiagnosticSignError",
	text = "✘",
	numhl = "",
})

vim.fn.sign_define("DiagnosticSignWarn", {
	texthl = "DiagnosticSignWarn",
	text = "▲",
	numhl = "",
})

vim.fn.sign_define("DiagnosticSignHint", {
	texthl = "DiagnosticSignHint",
	text = "⚑",
	numhl = "",
})

vim.fn.sign_define("DiagnosticSignInfo", {
	texthl = "DiagnosticSignInfo",
	text = "",
	numhl = "",
})
