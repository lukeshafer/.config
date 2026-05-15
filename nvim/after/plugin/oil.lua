local keys = require("lksh.keymaps")

local oil = require("oil")
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

keys.set_map("n", "<leader>e", function()
	oil.open_float(nil, { preview = { vertical = true } })
end)
keys.set_map("n", "<leader>E", function()
	oil.open_float(vim.api.nvim_buf_get_name(0))
end)
