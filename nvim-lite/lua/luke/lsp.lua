-- LSP Setups
local servers = {
	ts_ls = {
		init_options = { hostInfo = "neovim" },
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
