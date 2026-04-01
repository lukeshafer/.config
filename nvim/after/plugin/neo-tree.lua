require("neo-tree").setup({
	sort_case_insensitive = true,
	window = {
		position = "float",
		mappings = {
			["o"] = "open",
			["oc"] = "none",
			["od"] = "none",
			["og"] = "none",
			["om"] = "none",
			["on"] = "none",
			["os"] = "none",
			["ot"] = "none",
		},
	},
	filesystem = {
		filtered_items = {
			visible = false, -- when true, they will just be displayed differently than normal items
			hide_dotfiles = false,
			hide_gitignored = true,
			hide_hidden = true, -- only works on Windows for hidden files/directories
		},
	},
})

vim.keymap.set("n", "<leader>e", "<cmd>Neotree reveal<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>b", "<cmd>Neotree buffers reveal<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>g", "<cmd>Neotree git_status reveal<cr>", { noremap = true, silent = true })
