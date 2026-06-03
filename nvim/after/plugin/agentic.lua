local keys = require("lksh.keymaps")
local utils = require("lksh.utils")
local agentic = require("agentic")

utils.use_in_context("work", function()
	agentic.setup({
		provider = "kiro-acp",
		windows = {
			position = "right",
			width = "30%",
			height = "20%",
		},
		spinner_chars = {
			thinking = { "◐", "◓", "◑", "◒" },
			searching = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
		},
		message_icons = {
			thinking = "󰠗 ",
			finished = "✔ ",
			stopped = "⏹ ",
			error = "✖ ",
		},
		diagnostic_icons = {
			error = " ",
			warn = " ",
			info = " ",
			hint = " ",
		},
	})

	--session/update?

	-- Silence Kiro-specific ACP notifications that agentic doesn't handle
	local ACPClient = require("agentic.acp.acp_client")
	local orig_handle_notification = ACPClient._handle_notification
	function ACPClient:_handle_notification(message_id, method, params)
		if method:match("^_kiro%.dev/") then
			require("agentic.utils.logger").debug_to_file("kiro notification: ", method, params)
			return
		end

		-- if method:match("^_kiro%.dev/") then
		-- 	return
		-- end
		orig_handle_notification(self, message_id, method, params)
	end

	-- This plugin overrides the default fcs_choice to prompt if you have unsaved changes
	vim.api.nvim_create_autocmd("FileChangedShell", {
		group = vim.api.nvim_create_augroup("AgenticCleanup", { clear = false }),
		pattern = "*",
		callback = function()
			-- Default neovim behavior: prompt the user
			vim.v.fcs_choice = ""
		end,
	})

	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup("AgenticCleanup", { clear = false }),
		pattern = "AgenticInput",
		callback = function()
			vim.b.minicompletion_disable = true
		end,
	})

	-- Hook into LSRestart to preserve agentic session across restarts
	local agentic_id_path = vim.fn.stdpath("state") .. "/lsrestart-agentic-id"
	local SessionRegistry = require("agentic.session_registry")

	vim.api.nvim_create_autocmd("User", {
		pattern = "LSRestartPre",
		callback = function()
			local session = SessionRegistry.get_session_for_tab_page(nil)
			if session and session.session_id then
				vim.fn.writefile({ session.session_id }, agentic_id_path)
			else
				vim.fn.delete(agentic_id_path)
			end

			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if vim.bo[buf].filetype:match("^Agentic") then
					vim.api.nvim_buf_delete(buf, { force = true })
				end
			end
		end,
	})

	vim.api.nvim_create_autocmd("User", {
		pattern = "LSRestartPost",
		callback = function()
			if vim.fn.filereadable(agentic_id_path) == 0 then
				return
			end
			local lines = vim.fn.readfile(agentic_id_path)
			if #lines > 0 and lines[1] ~= "" then
				local saved_id = lines[1]
				vim.fn.delete(agentic_id_path)
				-- Wait for the auto-created session to finish initializing,
				-- then replace it with the restored session to avoid a race.
				SessionRegistry.get_session_for_tab_page(nil, function(session)
					session:on_session_ready(function(ready_session)
						ready_session:load_acp_session(saved_id, nil, nil)
						ready_session.widget:show()
					end)
				end)
			end
		end,
	})

	keys.set_map({ "n", "v" }, "<leader>at", agentic.toggle, { desc = "Toggle agent chat" })
	keys.set_map({ "n" }, "<leader>ar", function()
		local session_dir = vim.fn.expand("~/.kiro/sessions/cli")
		local files = vim.fn.glob(session_dir .. "/*.json", false, true)
		if #files == 0 then
			vim.notify("No saved sessions found", vim.log.levels.INFO)
			return
		end

		local cwd = vim.fn.getcwd()
		local sessions = {}
		for _, f in ipairs(files) do
			local ok, data = pcall(function()
				return vim.json.decode(table.concat(vim.fn.readfile(f), "\n"))
			end)
			if ok and data and data.cwd == cwd then
				table.insert(sessions, {
					id = data.session_id,
					title = data.title or "(no title)",
					updated_at = data.updated_at or "",
				})
			end
		end

		table.sort(sessions, function(a, b)
			return a.updated_at > b.updated_at
		end)

		if #sessions == 0 then
			vim.notify("No sessions found for " .. cwd, vim.log.levels.INFO)
			return
		end

		vim.ui.select(sessions, {
			prompt = "Select session to restore:",
			format_item = function(item)
				local date = item.updated_at:sub(1, 16):gsub("T", " ")
				return string.format("%s - %s", date, item.title)
			end,
		}, function(choice)
			if choice then
				agentic.restore_session_by_id(choice.id)
			end
		end)
	end, { desc = "Restore agent session" })
	keys.set_map({ "n", "v" }, "<leader>an", agentic.new_session, { desc = "New agent session" })
	keys.set_map(
		{ "n", "v" },
		"<leader>ac",
		agentic.add_selection_or_file_to_context,
		{ desc = "Add file or selection to agent context" }
	)
	keys.set_map(
		{ "n", "v" },
		"<leader>ad",
		agentic.add_current_line_diagnostics,
		{ desc = "Add current line diagnostics to agent context" }
	)
	keys.set_map(
		{ "n", "v" },
		"<leader>aD",
		agentic.add_current_line_diagnostics,
		{ desc = "Add buf diagnostics to agent context" }
	)
end)
