local ok, oil = pcall(require, "oil")
if not ok then
	return
end
oil.setup({
	columns = {
		"icon",
		{ "mtime", highlight = "LineNr" },
	},
	view_options = {
		show_hidden = true,
		case_insensitive = true,
		sort = {
			{ "type", "asc" },
			{ "name", "asc" },
			-- { "mtime", "desc" },
		},
	},
	delete_to_trash = true,
	win_options = {
		number = false,
		signcolumn = "yes:2",
	},
	keymaps = {
		["<C-q>"] = { "actions.close", mode = "n" },
	},
	float = {
		padding = 6,
		max_height = 55,
		border = "bold",
	},
})

require("oil-git-status").setup({})

vim.keymap.set("n", "<leader>e", function()
	oil.open()
end, { desc = "Open oil file explorer in buffer" })
vim.keymap.set("n", "<leader>E", function()
	oil.open_float(nil, { preview = { vertical = true } })
end, { desc = "Open oil file explorer in floating window" })
