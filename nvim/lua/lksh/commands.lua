---@param t table
---@param depth integer?
---@return string
local function format_table(t, depth)
	depth = depth or 0
	---@type string
	-- local table_str = ""
	local indent = string.format("%" .. depth .. "s", "")
	local table_str_lines = {}

	for k, v in pairs(t) do
		if type(v) == "table" then
			table.insert(
				table_str_lines,
				table.concat({
					indent,
					k,
					" = {\n",
					format_table(v, depth + 2),
					"\n",
					indent,
					"}",
				})
			)
		else
			table.insert(
				table_str_lines,
				table.concat({
					indent,
					k,
					" = ",
					tostring(v),
				})
			)
		end
	end

	return table.concat(table_str_lines, "\n")
end

local is_debug = false
local function log_debug(value)
	if is_debug then
		if type(value) == "table" then
			print(format_table(value))
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
