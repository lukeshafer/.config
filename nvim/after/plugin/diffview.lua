vim.keymap.set("n", "<leader>vo", "<cmd>DiffviewOpen<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>vc", "<cmd>DiffviewClose<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>vm", "<cmd>DiffviewOpen origin/main<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>vd", "<cmd>DiffviewOpen origin/dev<cr>", { noremap = true, silent = true })
