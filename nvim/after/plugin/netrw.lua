vim.keymap.set("n", "<leader>e", ":Explore<cr>", {})

vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_list_hide = vim.fn["netrw_gitignore#Hide"]() .. [[,.git/]]
