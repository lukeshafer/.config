local utils = require("lksh.utils")
local ok, conform = pcall(require, "conform")
if not ok then return end

local js_formatter = utils.use_in_context("personal", { "prettier" }, {})

conform.setup({
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
		asl = { "fixjson" },
		soql = { "sleek" },
		markdown = { "cbfmt" },
	},
})

vim.keymap.set("n", "<leader>f", function()
	conform.format({ timeout_ms = 2000, lsp_fallback = true })
end, { desc = "Format buffer" })
