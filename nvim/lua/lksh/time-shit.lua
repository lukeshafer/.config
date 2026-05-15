local M = {}

local function time_smthng(cb)
	local t1 = vim.uv.now()
	cb()
	local t2 = vim.uv.now()
	return t2 - t1
end

function M.go()
	-- local result = time_smthng(function()
    local t1 = vim.uv.now()
		local r = 0
		for i = 0, 10000 do
			r = r + i
		end

    print(r)

    local t2 = vim.uv.now()
    local result = t2 - t1
	-- end)

  print(result)

	vim.g.luketime = result
end

LKTIME = M
return M
