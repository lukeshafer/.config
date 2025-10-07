---@type vim.lsp.Config
return {
	cmd = { "typescript-language-server", "--stdio" },
	init_options = {
		hostInfo = "neovim",
		preferences = { disableSuggestions = true },
	},
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
}
