local utils = require("lksh.utils")
local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = utils.js_formatter,
		typescript = utils.js_formatter,
		javascriptreact = utils.js_formatter,
		typescriptreact = utils.js_formatter,
		jsx = utils.js_formatter,
		tsx = utils.js_formatter,
		astro = utils.js_formatter,
		json = { "fixjson" },
		java = { "google-java-format" },
		go = { "golines", "goimports", "gofumpt" },
		soql = { "sleek" },
	},
})

vim.keymap.set("n", "<leader>f", function()
	conform.format({ timeout_ms = 2000, lsp_fallback = true })
end, { noremap = true, silent = true })
