local function center_floating_window()
	-- Config for floating window
	local width_percent = 0.9
	local height_percent = 0.9

	local win_width = vim.api.nvim_win_get_width(0)
	local win_height = vim.api.nvim_win_get_height(0)

	local width = math.ceil(win_width * width_percent)
	local height = math.ceil(win_height * height_percent)

	local col = math.ceil((win_width - width) / 2)
	local row = math.ceil((win_height - height) / 2)

	print(win_width)
	return {
		relative = "editor",
		border = "rounded",
		width = width,
		height = height,
		row = row,
		col = col,
	}
end

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
		float = {
			enable = true,
			quit_on_focus_loss = true,
			open_win_config = center_floating_window,
		},
	},
	filters = {
		--dotfiles = true,
	},
	remove_keymaps = {
		--"q",
		"f",
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

--vim.cmd("highlight NvimTreeNormal guibg=#191724")
--vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true })
--vim.keymap.set("n", "<leader>e", toggle_nvim_focus, { noremap = true })
vim.keymap.set("n", "<leader>e", api.tree.toggle, { noremap = true })

--vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
