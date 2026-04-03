local utils = require("lksh.utils")

local is_debug = false
local function log_debug(value)
	if is_debug then
		if type(value) == "table" then
			print(utils.format_table(value))
		else
			print(value)
		end
		print("---")
	end
end

vim.api.nvim_create_user_command("LSSortList", function(opts)
	-- log_debug(opts)

	local buf = vim.api.nvim_get_current_buf()
	local _, row1 = unpack(vim.fn.getcharpos("."))
	local _, row2 = unpack(vim.fn.getcharpos("v"))

	if row1 > row2 then
		local temp = row1
		row1 = row2
		row2 = temp
	end

	if opts.line2 > row2 then
		row2 = opts.line2
	end

	log_debug({
		row1 = row1,
		row2 = row2,
	})

	local lines = vim.api.nvim_buf_get_lines(buf, row1 - 1, row2, false)
	log_debug(lines)

	table.sort(lines)
	log_debug(lines)
	vim.api.nvim_buf_set_lines(buf, row1 - 1, row2, false, lines)
end, { range = true })
