if vim.g.vscode then
	require("lksh.vsc-config")
elseif vim.env.PC_CONTEXT == "lite" then
	require("lksh.lite-config")
else
	LKSH = {
		opts = require("lksh.opts"),
		keymap = require("lksh.keymaps"),
		commands = require("lksh.commands"),
		plugins = require("lksh.plugins"),
		lsp = require("lksh.lsp"),
		statusline = require("lksh.statusline"),
		tabline = require("lksh.tabline"),
		utils = require("lksh.utils"),
	}

	LKSH.opts.init()
	LKSH.keymap.init()
	LKSH.commands.init()
	LKSH.plugins.init()
	LKSH.lsp.init()
	LKSH.statusline.init()
	LKSH.tabline.init()
end
