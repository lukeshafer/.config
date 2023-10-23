local cmp = require("cmp")

cmp.setup({
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp", keyword_length = 0 },
		{ name = "buffer",   keyword_length = 3 },
		{ name = "luasnip",  keyword_length = 1 },
	},
	mapping = cmp.mapping.preset.insert({
		-- Enter key confirms completion item
		['<CR>'] = cmp.mapping.confirm({ select = false }),
		-- Ctrl + y confirms completion item
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		-- Ctrl + space triggers completion menu
		['<C-Space>'] = cmp.mapping.complete(),
	}),
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
})
