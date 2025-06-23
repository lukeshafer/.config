---@param text string
local function get_seed_from_string(text)
	local value = 0
	local prev = 3
	local MAX = 1e7

	for c in text:gmatch(".") do
		local b = c:byte()

		if prev > b then
			value = b * (value + prev * b)
		elseif prev < b then
			value = prev * (value - prev * b)
		end

		value = math.fmod(value, MAX)
		prev = b
	end

	return value
end

local function gen_random_base_colors()
	local convert = require("mini.colors").convert
	local bghue = math.random(120, 359)

	local hueDiff = 90 * math.random(0, 4) - 180
	local fghue = math.fmod(bghue + hueDiff, 360)
	return {
		background = convert({ l = 11, c = 2, h = bghue }, "hex"),
		foreground = convert({ l = 85, c = 4, h = fghue }, "hex"),
	}
end

return {
	"echasnovski/mini.hues",
	dependencies = { "echasnovski/mini.colors" },
	version = false,
	lazy = false,
	config = function()
		-- Generate random config with initialized random seed based on cwd
		local seed = get_seed_from_string(vim.fn.getcwd())
		vim.g.lksh_color_seed = seed
		math.randomseed(seed)
		local base_colors = gen_random_base_colors()

		require("mini.hues").setup({
			background = base_colors.background,
			foreground = base_colors.foreground,
			n_hues = 8,
			saturation = vim.o.background == "dark" and "medium" or "high",
			accent = "fg",
		})

		vim.g.colors_name = "randomhue"

		-- vim.cmd("colorscheme randomhue")
	end,
}
