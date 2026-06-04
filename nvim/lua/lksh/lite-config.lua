-- Lite mode: minimal editor config with no plugins, no LSP, no custom UI
-- Activated when PC_CONTEXT=lite

require("lksh.opts").init()
require("lksh.keymaps").init()

-- Netrw
vim.g.netrw_liststyle = 3
vim.keymap.set("n", "<leader>e", ":Explore<cr>", { desc = "Open netrw explorer" })
