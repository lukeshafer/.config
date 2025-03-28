---@type vim.lsp.Config
return {
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
}
