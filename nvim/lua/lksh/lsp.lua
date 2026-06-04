local utils = require("lksh.utils")

local LSP = {}

function LSP.init()
	vim.lsp.enable({
		"html",
		"jsonls",
		"lua_ls",
		"ts_ls",
		-- "tsgo",
		"yamlls",
		"emmet_language_server",
		"bashls",
	})

	utils.use_in_context("work", function()
		-- vim.lsp.enable({
		-- "ts_ls",
		-- })
	end, function()
		-- NOT NEEDED AT WORK
		vim.lsp.enable({
			"astro",
			"cssls",
			-- "tsgo",
			-- "emmet_ls",
			"tailwindcss",
			"pico8_ls",
		})
	end)

	utils.use_in_context("desktop-wsl", function()
		vim.lsp.config.gdscript = { cmd = { "godot-wsl-lsp" } }
	end)

	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(ev)
			local client = vim.lsp.get_client_by_id(ev.data.client_id)
			if client and client:supports_method("textDocument/inlayHint") then
				vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
			end

			local opts = { buffer = ev.buf }
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to definition" })
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Go to declaration" })
			vim.keymap.set("n", "gl", vim.diagnostic.open_float, { buffer = ev.buf, desc = "Show diagnostic float" })
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover documentation" })
		end,
	})

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
end

return LSP
