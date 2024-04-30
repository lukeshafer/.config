local on_attach = function(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return {
			desc = "nvim-tree: " .. desc,
			buffer = bufnr,
			noremap = true,
			silent = true,
			nowait = true,
		}
	end

	api.config.mappings.default_on_attach(bufnr)

	-- your removals and mappings go here
	vim.keymap.set("n", "<leader>f", api.live_filter.start, opts("Filter"))
	vim.keymap.del("n", "f", { buffer = bufnr })
end

require("nvim-tree").setup({
	on_attach = on_attach,
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = true,
	},
	sort_by = "case_sensitive",
	view = {
		-- width = 40,
		side = "left",
		float = {
			enable = true,
			quit_on_focus_loss = true,
			open_win_config = {
				relative = "editor",
				border = "single", -- none, single, double, rounded, solid, shadow
				width = 50,
				height = vim.api.nvim_win_get_height(0) - 3,
				row = 1,
				col = 1,
			},
		},
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
	},
})

local api = require("nvim-tree.api")
vim.keymap.set("n", "<leader>e", api.tree.open, { noremap = true })
vim.keymap.set("n", "<leader>E", api.tree.toggle, { noremap = true })
-- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = api.tree.open })
