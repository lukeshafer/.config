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

	local bgL = vim.o.background == "dark" and math.random(10, 15) or math.random(85, 95) -- used to be 12
	local bgH = math.random(120, 360)
	local bgC = 4 * math.random() + 1 -- used to be 2

	local fgL = vim.o.background == "dark" and 87 or 10
	local fgC = 2 * math.random() + 1
	local fgH = math.random(0, 360)

	-- local sign = 2 * math.random(0,1) - 1 -- (+-1)
	-- local hueDiff = sign * math.random(45, 135)
	-- local hueDiff = 180 * math.random(0, 1) - 90

	-- local fghue = math.fmod(bgH + hueDiff, 360)
	return {
		background = convert({ l = bgL, c = bgC, h = bgH }, "hex"),
		foreground = convert({ l = fgL, c = fgC, h = fgH }, "hex"),
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

		vim.g.lksh_background = base_colors.background
		vim.g.lksh_foreground = base_colors.foreground

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
