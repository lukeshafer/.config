--require("penvim").setup({
--rooter = {
--enable = true, -- enable/disable rooter
--patterns = { ".__nvim__.lua", ".git" },
--},
--})
require("project_nvim").setup({
	detection_methods = { "pattern", "lsp" },
	patterns = { ".git", ".gitignore" },
})

require("nvim-highlight-colors").setup({
	render = "background", -- or 'foreground' or 'first_column'
	enable_named_colors = true,
	enable_tailwind = true,
})

vim.g.blamer_enabled = 1

vim.api.nvim_set_keymap("n", "cp", ":CccPick<CR>", { noremap = true })

require("lualine").setup()
