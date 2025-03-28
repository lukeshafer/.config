---@type vim.lsp.Config
return {
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
}
