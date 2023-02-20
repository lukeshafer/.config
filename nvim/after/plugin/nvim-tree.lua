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
	-- DEPRECATED
	--open_on_setup = true,
	--open_on_setup_file = true,
	remove_keymaps = {
		"q",
		"f",
	},
	renderer = {
		icons = {
			webdev_colors = false,
		},
	},
})

local api = require("nvim-tree.api")

local function open_nvim_tree()
	api.tree.open()
end

local isFocused = false
local function toggle_nvim_focus()
	if isFocused then
		vim.cmd("wincmd p")
		isFocused = false
	else
		api.tree.focus()
		isFocused = true
	end
end

vim.cmd("highlight NvimTreeNormal guibg=#191724")
--vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true })
vim.keymap.set("n", "<leader>e", toggle_nvim_focus, { noremap = true })
vim.keymap.set("n", "<leader>E", api.tree.toggle, { noremap = true })

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
