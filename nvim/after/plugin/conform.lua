local js_formatters = { { "prettier" } }
local conform_setup = {
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = js_formatters,
		typescript = js_formatters,
		javascriptreact = js_formatters,
		typescriptreact = js_formatters,
		jsx = js_formatters,
		tsx = js_formatters,
		astro = js_formatters,
		json = { "fixjson" },
	},
}

local atWork = os.getenv("PC_CONTEXT") == "work"
if not atWork then
	conform_setup.format_on_save = { timeout_ms = 500, lsp_fallback = true }
end

require("conform").setup(conform_setup)
