require("telescope").setup({
	defaults = { file_ignore_patterns = { "node_modules", "dist", "build" } },
	pickers = { find_files = { hidden = true } },
})

vim.keymap.set("n", "ff", function()
	require("telescope.builtin").find_files()
end, { noremap = true, silent = true })
vim.keymap.set("n", "fg", function()
	require("telescope.builtin").live_grep()
end, { noremap = true, silent = true })
vim.keymap.set("n", "fb", function()
	require("telescope.builtin").buffers()
end, { noremap = true, silent = true })
vim.keymap.set("n", "fh", function()
	require("telescope.builtin").help_tags()
end, { noremap = true, silent = true })
