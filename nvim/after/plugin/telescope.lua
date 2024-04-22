local builtin = require("telescope.builtin")

--require("telescope").load_extension("projects")
require("telescope").setup({
	defaults = {
		file_ignore_patterns = { "node_modules", "dist", "build", ".git" },
		-- layout_strategy = 'vertical'
	},
	pickers = {
		find_files = {
			hidden = true,
		},
	},
})

vim.keymap.set("n", "ff", builtin.find_files, {})
vim.keymap.set("n", "fg", builtin.live_grep, {})
vim.keymap.set("n", "fb", builtin.buffers, {})
vim.keymap.set("n", "fh", builtin.help_tags, {})
--vim.keymap.set("n", "fp", require("telescope").extensions.projects.projects, {})
