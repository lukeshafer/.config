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

	vim.api.nvim_create_user_command("LSBlame", function(opts)
		local l1, l2
		if opts.range == 2 then
			l1 = opts.line1
			l2 = opts.line2
		else
			l1 = vim.fn.line(".")
			l2 = l1
		end
		local filename = vim.api.nvim_buf_get_name(0)
		vim.cmd("Git blame -L " .. l1 .. "," .. l2 .. " " .. filename)
	end, { range = true })
end

return Commands
