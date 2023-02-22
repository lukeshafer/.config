--local function format_name(buf)
--local matchers = {
--"index.",
--"style.",
--"+page.",
--"+server.",
--"+layout.",
--"+error.",
--}
----return buf.path

--for _, matcher in ipairs(matchers) do
--print(buf.path)
--if string.match(buf.name, matcher) then
--local s = string.match(buf.path, "-/(^/)+/*.*")
--return s .. "helo"
----return string.match(buf.path, "%a+/" .. buf.name .. "$")
--end
--end

--return buf.name
--end

require("bufferline").setup({
	options = {
		right_mouse_command = nil, -- can be a string | function, see "Mouse actions"
		middle_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
		truncate_names = false,
		color_icons = false,
		hover = {
			enabled = true,
			delay = 0,
			reveal = { "close" },
		},
		separator_style = "thick",
		--name_formatter = format_name,
	},
})
