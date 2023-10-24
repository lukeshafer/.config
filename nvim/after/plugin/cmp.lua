local cmp = require("cmp")

cmp.setup({
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp", keyword_length = 0 },
		{ name = "luasnip",  keyword_length = 1 },
		{ name = "buffer",   keyword_length = 3 },
	},
	mapping = cmp.mapping.preset.insert({
		-- Enter key confirms completion item
		['<CR>'] = cmp.mapping.confirm({ select = false }),
		-- Ctrl + y confirms completion item
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		-- Ctrl + space triggers completion menu
		['<C-Space>'] = cmp.mapping.complete(),
		-- Tab and S-Tab move through completion menu
		['<Tab>'] = cmp.mapping.select_next_item(),
		['<S-Tab>'] = cmp.mapping.select_prev_item(),
	}),
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
})
