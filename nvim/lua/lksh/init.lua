if vim.g.vscode then
	require("lksh.vsc-config")
	return
end

require("lksh.plugins")
require("lksh.config")
require("lksh.lsp")
require("lksh.commands")
require("lksh.keymaps")
require("lksh.statusline")
