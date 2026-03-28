---@param seed integer
local function prepare_color_theme(seed)
	local convert = require("mini.colors").convert

	math.randomseed(seed)

	local bg = convert({
		l = vim.o.background == "dark" and 12 or 85,
		c = 3,
		h = math.random(180, 360),
	}, "hex")

	local fg = convert({
		l = vim.o.background == "dark" and 87 or 10,
		c = 2,
		h = math.random(0, 360),
	}, "hex")

	require("mini.hues").setup({
		background = bg,
		foreground = fg,
		n_hues = 8,
		saturation = vim.o.background == "dark" and "medium" or "high",
		accent = "fg",
	})

	vim.g.lksh_color_seed = seed
	vim.g.lksh_background = bg
	vim.g.lksh_foreground = fg
	vim.g.colors_name = "randomhue"
end

return {
	prepare_color_theme = prepare_color_theme,
}
