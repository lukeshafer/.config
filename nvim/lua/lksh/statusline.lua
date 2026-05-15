-- Statusline Modules

-- local component_separators = { left = "", right = "" }
-- local section_separators = { left = "", right = "" }

local hl_groups = {
	base = "%#StatusLine#",
	m_normal = "%#StatusLine#",
	m_visual = "%#Cursor#",
	m_insert = "%#Cursor#",
	m_cmd = "%#Cursor#",
}

local mode_icons = {
	-- normal = "%#MiniStatuslineModeNormal#  %#WhichKeyFloat#",
	-- visual = "%#MiniStatuslineModeVisual# 󰗧 %#DiagnosticFloatingOk#",
	-- insert = "%#MiniHipatternsTodo#  %#DiagnosticFloatingInfo#",
	-- command = "%#MiniStatuslineModeCommand#  %#DiagnosticFloatingWarn#",
	normal = "%#StatusLine#   ",
	visual = "%#Cursor# 󰗧  ",
	insert = "%#DiffText#   ",
	command = "%#IncSearch#   ",
}

local modes = {
	["n"] = mode_icons.normal,
	["no"] = mode_icons.normal,
	["v"] = mode_icons.visual,
	["V"] = mode_icons.visual,
	[""] = mode_icons.visual,
	["s"] = mode_icons.visual,
	["S"] = mode_icons.visual,
	[""] = mode_icons.visual,
	["i"] = mode_icons.insert,
	["ic"] = mode_icons.insert,
	["R"] = mode_icons.insert,
	["Rv"] = mode_icons.insert,
	["c"] = mode_icons.command,
	["cv"] = mode_icons.command,
	["ce"] = mode_icons.command,
	["r"] = "PROMPT",
	["rm"] = "MOAR",
	["r?"] = "CONFIRM",
	["!"] = mode_icons.command,
	["t"] = mode_icons.command,
}

local function mode()
	local current_mode = vim.api.nvim_get_mode().mode

	return string.format("%s%s", modes[current_mode], "%#StatusLine#")
end

local function filepath()
	local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.:h")

	if fpath == "" or fpath == "." then
		return " "
	end

	return string.format(" %%<%s/", fpath)
end

local function filename()
	local fname = vim.fn.expand("%:t")
	if fname == "" then
		return ""
	end
	return fname .. " "
end

local function lsp()
	local count = {}
	local levels = {
		errors = vim.diagnostic.severity.ERROR,
		warnings = vim.diagnostic.severity.WARN,
		info = vim.diagnostic.severity.INFO,
		hints = vim.diagnostic.severity.HINT,
	}

	for k, level in pairs(levels) do
		count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
	end

	local errors = ""
	local warnings = ""
	local hints = ""
	local info = ""

	if count["errors"] ~= 0 then
		errors = " %#ErrorMsg# " .. count["errors"]
	end
	if count["warnings"] ~= 0 then
		warnings = " %#WarningMsg# " .. count["warnings"]
	end
	if count["hints"] ~= 0 then
		hints = " %#ModeMsg# " .. count["hints"]
	end
	if count["info"] ~= 0 then
		info = " %#MoreMsg# " .. count["info"]
	end

	return errors .. warnings .. hints .. info .. "%#StatusLine#"
end

local function filetype()
	return string.format(" %s ", vim.bo.filetype):lower()
end

local function lineinfo()
	if vim.bo.filetype == "alpha" then
		return ""
	end
	return " %l:%c "
end

local git = function()
	if not vim.b.minidiff_summary or not vim.b.minigit_summary then
		return ""
	end

	local diff_summary = vim.b.minidiff_summary
	local git_summary = vim.b.minigit_summary or {}

	local diffadd = vim.b.minidiff_summary.add
	local diffch = vim.b.minidiff_summary.change
	local diffdel = vim.b.minidiff_summary.delete

	local added = ""
	if (vim.b.minidiff_summary.add or 0) > 0 then
		added = string.format("%%#OkMsg#+%i", vim.b.minidiff_summary.add)
	end

	local result = table.concat({
		hl_groups.base,
		"(",
		git_summary.head_name,
		" ",
	})

	local git_data = vim.b.minidiff_summary_string
	if git_data then
		return git_data
	end
	string.format("")

	local git_info = vim.b.gitsigns_status_dict
	if not git_info or git_info.head == "" then
		return ""
	end
	local added = git_info.added and ("%#DiagnosticFloatingOk#+" .. git_info.added .. " ") or ""
	local changed = git_info.changed and ("%#DiagnosticFloatingWarn#~" .. git_info.changed .. " ") or ""
	local removed = git_info.removed and ("%#DiagnosticFloatingError#-" .. git_info.removed .. " ") or ""
	if git_info.added == 0 then
		added = ""
	end
	if git_info.changed == 0 then
		changed = ""
	end
	if git_info.removed == 0 then
		removed = ""
	end
	return table.concat({
		" ",
		"%#DiagnosticFloatingInfo# ",
		git_info.head,
		-- "%#StatusLineNC#",
		" ",
		added,
		changed,
		removed,
		" %#StatusLineNC#",
		-- component_separators.left,
	})
end

local Statusline = {}

function Statusline.active()
	return table.concat({
		"%#StatusLineNC#",
		mode(),
		git(),
		"%#StatusLineNC# ",
		filepath(),
		filename(),
		" %m",
		"%#StatusLineNC#",
		lsp(),
		"%=%#StatusLineNC#",
		filetype(),
		lineinfo(),
		"%#StatusLineNC#",
	})
end

function Statusline.inactive()
	return " %F %m "
end

function Statusline.init()
	local group = vim.api.nvim_create_augroup("Statusline", {})
	vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
		group = group,
		callback = function()
			vim.opt_local.statusline = "%!v:lua.require('lksh.statusline').active()"
		end,
	})

	vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
		group = group,
		callback = function()
			vim.opt_local.statusline = "%!v:lua.require('lksh.statusline').inactive()"
		end,
	})
end

return Statusline
