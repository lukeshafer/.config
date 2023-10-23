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

local function my_on_attach(bufnr)
	local api = require('nvim-tree.api')

	local function opts(desc)
		return {
			desc = 'nvim-tree: ' .. desc,
			buffer = bufnr,
			noremap = true,
			silent = true,
			nowait = true
		}
	end

	api.config.mappings.default_on_attach(bufnr)

	-- your removals and mappings go here
	vim.keymap.set('n', '<leader>f', api.live_filter.start, opts('Filter'))
	vim.keymap.del('n', 'f', { buffer = bufnr })
end

require("nvim-tree").setup({
	on_attach = my_on_attach,
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = true,
	},
	sort_by = "case_sensitive",
	view = {
		width = 40,
		float = {
			enable = true,
			quit_on_focus_loss = true,
			open_win_config = center_floating_window,
		},
	},
})

local api = require("nvim-tree.api")
vim.keymap.set("n", "<leader>E", api.tree.toggle, { noremap = true })
