if vim.g.vscode then
	require("lksh.vsc-config")
	return
end

if vim.version.range(">=0.12.0"):has(vim.version()) then
	require("lksh.plugins")
else
	require("lksh.plugins-lazy")
end

require("lksh.config")
require("lksh.lsp")
require("lksh.commands")
require("lksh.keymaps")
require("lksh.statusline")
