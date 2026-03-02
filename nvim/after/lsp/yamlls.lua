---@type vim.lsp.Config
return {
	settings = {
		-- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
		redhat = { telemetry = { enabled = false } },
		yaml = {
      format = {
        enable = true
      },
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
}
