-- OR setup with some options
require("nvim-tree").setup({
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = true,
	},
	sort_by = "case_sensitive",
	view = {
		width = 40,
		mappings = {
			list = {
				--{ key = "u", action = "dir_up" },
				{ key = "<leader>f", action = "live_filter" },
			},
		},
	},
	filters = {
		dotfiles = true,
	},
	open_on_setup = true,
	open_on_setup_file = true,
	remove_keymaps = {
		"q",
		"f",
	},
	tab = {
		sync = {
			open = true,
			close = true,
		},
	},
})

vim.cmd("highlight NvimTreeNormal guibg=#191724")
--vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true })
