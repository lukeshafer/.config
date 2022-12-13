require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
	log_level = vim.log.levels.DEBUG,
})
require("mason-lspconfig").setup({
	--lspconfig-server-configurations
	ensure_installed = {
		"astro",
		"cssls",
		"tsserver",
		"emmet_ls",
		"eslint",
		"html",
		"svelte",
		"tailwindcss",
		"vimls",
		"bashls",
	},
})
