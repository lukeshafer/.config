-- Autocompletion
return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
	},
	config = function()
		local cmp = require("cmp")

		cmp.setup({
			sources = cmp.config.sources({
				{ name = "nvim_lsp", keyword_length = 0 },
				{ name = "luasnip", keyword_length = 1 },
			}, {
				{ name = "path" },
				{ name = "buffer", keyword_length = 3 },
			}),
			mapping = cmp.mapping.preset.insert({
				["<CR>"] = cmp.mapping.confirm({ select = false }), -- Enter key confirms completion item
				["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Ctrl + y confirms completion item
				["<C-Space>"] = cmp.mapping.complete(), -- Ctrl + space triggers completion menu
				["<Tab>"] = cmp.mapping.select_next_item(), -- Tab and S-Tab move through completion menu
				["<S-Tab>"] = cmp.mapping.select_prev_item(),
			}),
			snippet = {
				expand = function(args)
					vim.snippet.expand(args.body)
					-- require("luasnip").lsp_expand(args.body)
				end,
			},
		})
	end,
}
