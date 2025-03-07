if vim.g.vscode then
	require("lksh.vsc-plugins")
else
	require("lksh.plugins")
end

require('lksh.config')
require('lksh.keymaps')
