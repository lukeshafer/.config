if vim.g.vscode then
	require("lksh.vsc-config")
	return
end

require("lksh.plugins")
-- require("lksh.statusline")
require("lksh.config")
require("lksh.lsp")
require("lksh.keymaps")
