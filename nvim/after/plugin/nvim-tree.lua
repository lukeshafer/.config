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
		--adaptive_size = true,
		mappings = {
			list = {
				--{ key = "u", action = "dir_up" },
			},
		},
		side = "right",
		float = {
			enable = true,
			open_win_config = {
				width = 50,
				height = 30,
				row = 1,
				col = 10,
			},
		},
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},
})
