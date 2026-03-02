local function js_formatter()
	if os.getenv("PC_CONTEXT") then
		return {}
	end

	return { "prettier" }
end

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
	local bgH = math.random(180, 360)
	local bgC = 4 * math.random() + 1 -- used to be 2

	local fgL = vim.o.background == "dark" and 87 or 10
	local fgC = 2 * math.random() + 1
	local fgH = math.random(0, 360)

	return {
		background = convert({ l = bgL, c = bgC, h = bgH }, "hex"),
		foreground = convert({ l = fgL, c = fgC, h = fgH }, "hex"),
	}
end

return {
	js_formatter = js_formatter,
	get_seed_from_string = get_seed_from_string,
	gen_random_base_colors = gen_random_base_colors,
}
