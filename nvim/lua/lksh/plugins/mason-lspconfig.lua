return {
	"williamboman/mason-lspconfig.nvim",
	lazy = false,
	opts = {
		ensure_installed = {
			-- "astro",
			-- "eslint",
			"cssls",
			"emmet_ls",
			"html",
			"jsonls",
			"lua_ls",
			-- "tailwindcss",
			"ts_ls",
		},
		handlers = {
			function(server)
				require("lspconfig")[server].setup({})
			end,
			lua_ls = function()
				require("lspconfig").lua_ls.setup({
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							diagnostics = { globals = { "vim" } },
							workspace = { library = { vim.env.VIMRUNTIME } },
						},
					},
				})
			end,
			ts_ls = function()
				local nvim_lsp = require("lspconfig")
				nvim_lsp.ts_ls.setup({
					init_options = { preferences = { disableSuggestions = true } },
					root_dir = nvim_lsp.util.root_pattern("package.json"),
					single_file_support = false,
				})
			end,
			denols = function()
				local nvim_lsp = require("lspconfig")
				nvim_lsp.denols.setup({
					root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
				})
			end,
			yamlls = function()
				require("lspconfig").yamlls.setup({
					settings = {
						yaml = {
							customTags = {
								"!Equals sequence",
								"!FindInMap sequence",
								"!GetAtt",
								"!GetAZs",
								"!ImportValue",
								"!Join sequence",
								"!Ref",
								"!Select sequence",
								"!Split sequence",
								"!Sub",
								"!If sequence",
								"!Not sequence",
								"!Or sequence",
							},
						},
					},
				})
			end,
			jsonls = function()
				require("lspconfig").jsonls.setup({
					settings = {
						json = {
							schemas = {
								{
									fileMatch = { "package.json" },
									url = "https://json.schemastore.org/package.json",
								},
								{
									fileMatch = { "jsconfig*.json" },
									url = "https://json.schemastore.org/jsconfig.json",
								},
								{
									fileMatch = { "tsconfig*.json" },
									url = "https://json.schemastore.org/tsconfig.json",
								},
								{
									fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
									url = "https://json.schemastore.org/prettierrc.json",
								},
								{
									fileMatch = { ".eslintrc", ".eslintrc.json" },
									url = "https://json.schemastore.org/eslintrc.json",
								},
								{
									fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" },
									url = "https://json.schemastore.org/babelrc.json",
								},
								{
									fileMatch = {
										".stylelintrc",
										".stylelintrc.json",
										"stylelint.config.json",
									},
									url = "http://json.schemastore.org/stylelintrc.json",
								},
							},
						},
					},
				})
			end,
			tailwindcss = function()
				require("lspconfig").tailwindcss.setup({
					settings = {
						tailwindCSS = {
							classAttributes = {
								"class",
								"className",
								"class:list",
								"classList",
								"ngClass",
								".*Styles.*",
							},
							experimental = { classRegex = { { "/\\*tw\\*/ ([^;]*);", "'([^']*)'" } } },
						},
					},
				})
			end,
		},
	},
}
