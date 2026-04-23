local Commands = {}

function Commands.init()
	vim.api.nvim_create_user_command("LSSortList", function(opts)
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

		local lines = vim.api.nvim_buf_get_lines(buf, row1 - 1, row2, false)

		table.sort(lines)
		vim.api.nvim_buf_set_lines(buf, row1 - 1, row2, false, lines)
	end, { range = true })

	vim.api.nvim_create_user_command("LSRestart", function()
		local session_path = vim.fn.stdpath("state") .. "/lsrestart-session.vim"
		vim.cmd("mksession! " .. session_path .. " | restart source " .. session_path)
	end, {})
end

return Commands
