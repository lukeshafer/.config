-- https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/configs
-- ^ LSPConfig configs

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local opts = { noremap = true, silent = true, buffer = event.buf }

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)
		vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
	end,
})

-- LSP Setups
local servers = {
	ts_ls = {
		init_options = {
			hostInfo = "neovim",
			preferences = { disableSuggestions = true },
		},
		cmd = { "typescript-language-server", "--stdio" },
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
		root_dir = vim.fs.root(0, {
			"tsconfig.json",
			"jsconfig.json",
			"package.json",
			".git",
		}),
		single_file_support = true,
	},
	lua_ls = {
		name = "lua-language-server",
		cmd = { "lua-language-server" },
		root_dir = vim.fs.root(0, {
			".luarc.json",
			".luarc.jsonc",
			".luacheckrc",
			".stylua.toml",
			"stylua.toml",
			"selene.toml",
			"selene.yml",
			".git",
		}),
		filetypes = { "lua" },
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				diagnostics = { globals = { "vim" } },
				workspace = { library = { vim.env.VIMRUNTIME } },
			},
		},
	},
	jsonls = {
		cmd = { "vscode-json-language-server", "--stdio" },
		filetypes = { "json", "jsonc" },
		init_options = {
			provideFormatter = true,
		},
		root_dir = vim.fs.root(0, { ".git" }),
		single_file_support = true,
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
				},
			},
		},
	},
	cssls = {
		cmd = { "vscode-css-language-server", "--stdio" },
		filetypes = { "css", "scss", "less" },
		init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
		root_dir = vim.fs.root(0, { "package.json", ".git" }),
		single_file_support = true,
		settings = {
			css = { validate = true },
			scss = { validate = true },
			less = { validate = true },
		},
	},
	html = {
		cmd = { "vscode-html-language-server", "--stdio" },
		filetypes = { "html", "templ" },
		root_dir = vim.fs.root(0, { "package.json", ".git" }),
		single_file_support = true,
		settings = {},
		init_options = {
			provideFormatter = true,
			embeddedLanguages = { css = true, javascript = true },
			configurationSection = { "html", "css", "javascript" },
		},
	},
	emmet_ls = {
		cmd = { "emmet-ls", "--stdio" },
		filetypes = {
			"astro",
			"css",
			"eruby",
			"html",
			"htmldjango",
			"javascriptreact",
			"less",
			"pug",
			"sass",
			"scss",
			"svelte",
			"typescriptreact",
			"vue",
			"htmlangular",
		},
		root_dir = vim.fs.root(0, { ".git" }),
		single_file_support = true,
	},
	yamlls = {
		cmd = { "yaml-language-server", "--stdio" },
		filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
		root_dir = vim.fs.root(0, { ".git" }),
		single_file_support = true,
		settings = {
			-- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
			redhat = { telemetry = { enabled = false } },
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
	},
	tailwindcss = {
		cmd = { "tailwindcss-language-server", "--stdio" },
		-- filetypes copied and adjusted from tailwindcss-intellisense
		filetypes = {
			-- html
			"aspnetcorerazor",
			"astro",
			"astro-markdown",
			"blade",
			"clojure",
			"django-html",
			"htmldjango",
			"edge",
			"eelixir", -- vim ft
			"elixir",
			"ejs",
			"erb",
			"eruby", -- vim ft
			"gohtml",
			"gohtmltmpl",
			"haml",
			"handlebars",
			"hbs",
			"html",
			"htmlangular",
			"html-eex",
			"heex",
			"jade",
			"leaf",
			"liquid",
			"markdown",
			"mdx",
			"mustache",
			"njk",
			"nunjucks",
			"php",
			"razor",
			"slim",
			"twig",
			-- css
			"css",
			"less",
			"postcss",
			"sass",
			"scss",
			"stylus",
			"sugarss",
			-- js
			"javascript",
			"javascriptreact",
			"reason",
			"rescript",
			"typescript",
			"typescriptreact",
			-- mixed
			"vue",
			"svelte",
			"templ",
		},
		settings = {
			tailwindCSS = {
				validate = true,
				lint = {
					cssConflict = "warning",
					invalidApply = "error",
					invalidScreen = "error",
					invalidVariant = "error",
					invalidConfigPath = "error",
					invalidTailwindDirective = "error",
					recommendedVariantOrder = "warning",
				},
				classAttributes = {
					"class",
					"className",
					"class:list",
					"classList",
					"ngClass",
				},
				includeLanguages = {
					eelixir = "html-eex",
					eruby = "erb",
					templ = "html",
					htmlangular = "html",
				},
			},
		},
		on_new_config = function(new_config)
			if not new_config.settings then
				new_config.settings = {}
			end
			if not new_config.settings.editor then
				new_config.settings.editor = {}
			end
			if not new_config.settings.editor.tabSize then
				-- set tab size for hover
				new_config.settings.editor.tabSize = vim.lsp.util.get_effective_tabstop()
			end
		end,
		root_dir = vim.fs.root(0, {
			"tailwind.config.js",
			"tailwind.config.cjs",
			"tailwind.config.mjs",
			"tailwind.config.ts",
			"postcss.config.js",
			"postcss.config.cjs",
			"postcss.config.mjs",
			"postcss.config.ts",
			"package.json",
			"node_modules",
			".git",
		}),
	},
	astro = {
		cmd = { "astro-ls", "--stdio" },
		filetypes = { "astro" },
		root_dir = vim.fs.root(0, { "package.json", "tsconfig.json", "jsconfig.json", ".git" }),
		init_options = {
			typescript = {
				hostInfo = "neovim",
				preferences = { disableSuggestions = true },
			},
		},
		on_new_config = function(new_config, new_root_dir)
			if vim.tbl_get(new_config.init_options, "typescript") and not new_config.init_options.typescript.tsdk then
				local project_root =
					vim.fs.dirname(vim.fs.find("node_modules", { path = new_root_dir, upward = true })[1])
				new_config.init_options.typescript.tsdk = project_root
						and (project_root .. "/node_modules/typescript/lib")
					or ""
			end
		end,
	},
}

local group = vim.api.nvim_create_augroup("user.lsp.start", {})
for name, config in pairs(servers) do
	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		pattern = config.filetypes,
		callback = function(ev)
			config.name = name
			if config.root_markers then
				config.root_dir = vim.fs.root(ev.buf, config.root_markers)
			end
			vim.lsp.start(config, { bufnr = ev.buf })
		end,
	})
end
