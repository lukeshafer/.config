local function js_formatter()
	if os.getenv("PC_CONTEXT") then
		return {}
	end

	return { "prettier" }
end

return {
	"stevearc/conform.nvim", -- Formatter management
	lazy = true,
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ timeout_ms = 2000, lsp_fallback = true })
			end,
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = js_formatter,
			typescript = js_formatter,
			javascriptreact = js_formatter,
			typescriptreact = js_formatter,
			jsx = js_formatter,
			tsx = js_formatter,
			astro = js_formatter,
			json = { "fixjson" },
			java = { "google-java-format" },
			go = { "golines", "goimports", "gofumpt" },
      soql = { "sleek" },
		},
	},
}
