---@type vim.lsp.Config
return {
	init_options = {
		enableLinting = false,
		-- https://rumdl.dev/rules/
		disableRules = { "MD022" },
		enableRules = {},
	},
	settings = {
		lineLength = 100,
		MD013 = {
			reflow = true,
		},
	},
}
