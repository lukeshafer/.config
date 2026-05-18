local utils = require("lksh.utils")
local keys = require("lksh.keymaps")

require("mini.notify").setup({})
require("mini.colors").setup({})
require("mini.cursorword").setup({})
require("mini.git").setup({})
require("mini.icons").setup({})
require("mini.pairs").setup({})
require("mini.surround").setup({})

local mini_extra = require("mini.extra")
mini_extra.setup()

--- MINI FILES ---
-- local mini_files = require("mini.files")
-- local file_utils = utils.mini_files_help_init()

-- mini_files.setup({
-- 	options = {
-- 		permanent_delete = false,
-- 		use_as_default_explorer = false,
-- 	},
-- 	mappings = {
-- 		go_in = "L", -- swap go in plus to close explorer by default
-- 		go_in_plus = "l",
-- 	},
-- 	content = {
-- 		highlight = file_utils.highlight_fn,
-- 		sort = file_utils.get_sort_fn(),
-- 	},
-- })

-- keys.set_map("n", "<leader>e", mini_files.open)
-- keys.set_map("n", "<leader>E", function()
-- 	mini_files.open(vim.api.nvim_buf_get_name(0))
-- end)

-- vim.api.nvim_create_autocmd({ "User" }, {
-- 	pattern = "MiniFilesBufferCreate",
-- 	callback = function(ev)
-- 		local buf_id = ev.data.buf_id
-- 		-- show_ignored = false
--
-- 		keys.set_map("n", "g.", function()
-- 			file_utils.toggle_ignored()
-- 			mini_files.refresh({
-- 				content = { sort = file_utils.get_sort_fn() },
-- 			})
-- 		end, { buffer = buf_id })
-- 	end,
-- })

--- MINI HUES ---
math.randomseed(utils.get_seed_from_string(vim.fn.getcwd()))
require("mini.hues").setup({
	background = require("mini.colors").convert({
		l = vim.o.background == "dark" and 12 or 85,
		c = 3,
		h = math.random(180, 360),
	}, "hex"),
	foreground = require("mini.colors").convert({
		l = vim.o.background == "dark" and 87 or 10,
		c = 2,
		h = math.random(0, 360),
	}, "hex"),
	n_hues = 8,
	saturation = vim.o.background == "dark" and "medium" or "high",
	accent = "fg",
})

vim.g.colors_name = "randomhue"

local kitty_pid = os.getenv("KITTY_PID")
if kitty_pid ~= nil and kitty_pid ~= "" then -- transparent bg on kitty
	vim.api.nvim_set_hl(0, "Normal", { update = true, bg = "none", ctermbg = "none" })
	vim.api.nvim_set_hl(0, "NonText", { update = true, bg = "none", ctermbg="none" })
end

--- MINI INDENTSCOPE ---
local mini_indentscope = require("mini.indentscope")
mini_indentscope.setup({
	draw = {
		delay = 0,
		animation = mini_indentscope.gen_animation.none(),
	},
	symbol = "▎",
})

--- MINI DIFF ---
local mini_diff = require("mini.diff")
mini_diff.setup({
	view = {
		priority = 1,
		style = "sign",
		signs = {
			add = "▎",
			change = "▎",
			delete = "▁",
		},
	},
})

vim.api.nvim_set_hl(0, "MiniDiffSignChange", { link = "diffFile" })
keys.set_map("n", "<leader>g", function()
	mini_diff.toggle_overlay(0)
end)

--- MINI COMPLETION ---
require("mini.completion").setup({})

vim.keymap.set("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
vim.keymap.set("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })

--- MINI PICK ---
local mini_pick = require("mini.pick")
mini_pick.setup({})

keys.set_map("n", "ff", mini_pick.builtin.files)
keys.set_map("n", "fg", mini_pick.builtin.grep_live)
keys.set_map("n", "fb", mini_pick.builtin.buffers)
keys.set_map("n", "fh", mini_pick.builtin.help)
keys.set_map("n", "fm", mini_extra.pickers.manpages)

--- MINI HIPATTERNS ---
local mini_hipatterns = require("mini.hipatterns")
mini_hipatterns.setup({
	highlighters = {
		fixme = { pattern = "FIXME", group = "MiniHipatternsFixme" },
		hack = { pattern = "HACK", group = "MiniHipatternsHack" },
		todo = { pattern = "TODO", group = "MiniHipatternsTodo" },
		note = { pattern = "NOTE", group = "MiniHipatternsNote" },
		hex_color = mini_hipatterns.gen_highlighter.hex_color(),
	},
})

--- MINI MAP ---
local mini_map = require("mini.map")

mini_map.setup({
	window = { width = 4 },
	integrations = {
		mini_map.gen_integration.builtin_search(),
		mini_map.gen_integration.diagnostic({
			error = "DiagnosticFloatingError",
			warn = "DiagnosticFloatingWarn",
			info = "DiagnosticFloatingInfo",
			hint = "DiagnosticFloatingHint",
		}),
	},
})

keys.set_map("n", "<leader>m", mini_map.toggle)
