-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    --adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
		side = "right",
		float = {
			enable = true,
			open_win_config = {
				width = 50,
				height = 40,
				row = 1,
				col = 10,
			},
		}
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },

})
