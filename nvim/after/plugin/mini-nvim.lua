-- ---@param text string
-- local function get_seed_from_string(text)
-- 	local value = 0
-- 	local prev = 3
-- 	local MAX = 1000
-- 	for c in text:gmatch(".") do
-- 		local b = c:byte()
-- 		value = math.fmod(b * (value + prev * b), MAX)
-- 		prev = b
-- 	end
-- 	return value
-- end

require("mini.notify").setup({})
require("mini.colors").setup({})
require("mini.cursorword").setup({})
require("mini.icons").setup({})
require("mini.pairs").setup({})
require("mini.surround").setup({})
require("mini.git").setup({
	command = {
		split = "vertical",
	},
})

local mini_extra = require("mini.extra")
mini_extra.setup()

local mini_colors = require("mini.colors")
mini_colors.setup({})

--- MINI HUES ---
-- math.randomseed(get_seed_from_string(vim.fn.getcwd()))

local bg_l, fg_l, sat
if vim.o.background == "dark" then
	bg_l = 5
	fg_l = 91
	sat = "medium"
else
	bg_l = 85
	fg_l = 10
	sat = "high"
end

-- require("mini.hues").setup({
-- 	background = MiniColors.convert({ l = bg_l, c = 2, h = math.random(180, 360) }, "hex"),
-- 	foreground = MiniColors.convert({ l = fg_l, c = 1, h = math.random(0, 360) }, "hex"),
-- 	n_hues = 8,
-- 	saturation = sat,
-- })
require("mini.hues").setup({
	background = MiniColors.convert({
		l = bg_l,
		c = 5,
		h = 315,
	}, "hex"),
	foreground = MiniColors.convert({
		l = fg_l,
		c = 2,
		h = 199,
	}, "hex"),
	n_hues = 8,
	saturation = sat,
})

vim.g.colors_name = "lukehue"

vim.api.nvim_set_hl(0, "Normal", { update = true, bg = "none", ctermbg = "none" })
vim.api.nvim_set_hl(0, "NonText", { update = true, bg = "none", ctermbg = "none" })

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
vim.keymap.set("n", "<leader>gd", function()
	mini_diff.toggle_overlay(0)
end, { desc = "Toggle git diff overlay" })

--- MINI COMPLETION ---
require("mini.completion").setup({})

vim.keymap.set("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true, desc = "Next completion or Tab" })
vim.keymap.set("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true, desc = "Prev completion or S-Tab" })

--- MINI PICK ---
local mini_pick = require("mini.pick")
mini_pick.setup({})

vim.keymap.set("n", "ff", mini_pick.builtin.files, { desc = "mini.pick Find files" })
vim.keymap.set("n", "fg", mini_pick.builtin.grep_live, { desc = "mini.pick Live grep" })
vim.keymap.set("n", "fb", mini_pick.builtin.buffers, { desc = "mini.pick Find buffers" })
vim.keymap.set("n", "fh", mini_pick.builtin.help, { desc = "mini.pick Find help tags" })
vim.keymap.set("n", "fm", mini_extra.pickers.manpages, { desc = "mini.pick Find man pages" })

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

vim.keymap.set("n", "<leader>m", mini_map.toggle, { desc = "mini.map Toggle minimap" })
