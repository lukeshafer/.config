local utils = require("lksh.utils")
local keys = require("lksh.keymaps")
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
		asl = { "fixjson" },
		soql = { "sleek" },
		markdown = { "cbfmt" },
	},
})

keys.set_map("n", "<leader>f", function()
	conform.format({ timeout_ms = 2000, lsp_fallback = true })
end)
