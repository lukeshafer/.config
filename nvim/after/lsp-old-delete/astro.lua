---@type vim.lsp.Config
return {
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
			local project_root = vim.fs.dirname(vim.fs.find("node_modules", { path = new_root_dir, upward = true })[1])
			new_config.init_options.typescript.tsdk = project_root and (project_root .. "/node_modules/typescript/lib")
				or ""
		end
	end,
}
