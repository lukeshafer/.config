---@type vim.lsp.Config
return {
	settings = {
		configPath = vim.fn.expand("~/.config/.oxfmtrc.json"),
    disableNestedConfig = false,
	},
}
