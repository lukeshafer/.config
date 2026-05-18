-- Statusline Modules

-- local component_separators = { left = "", right = "" }
-- local section_separators = { left = "", right = "" }

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
	["nt"] = mode_icons.normal,
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

local git = function()
	if not vim.b.minidiff_summary or not vim.b.minigit_summary then
		return ""
	end

	local added = ""
	if (vim.b.minidiff_summary.add or 0) > 0 then
		added = string.format(" %%#OkMsg#+%i", vim.b.minidiff_summary.add)
	end

	local changed = ""
	if (vim.b.minidiff_summary.change or 0) > 0 then
		changed = string.format(" %%#WarningMsg#~%i", vim.b.minidiff_summary.change)
	end

	local deleted = ""
	if (vim.b.minidiff_summary.delete or 0) > 0 then
		deleted = string.format(" %%#ErrorMsg#-%i", vim.b.minidiff_summary.delete)
	end

	local result = table.concat({
		"( ",
		vim.b.minigit_summary.head_name,
		added,
		changed,
		deleted,
		"%#StatusLine#)",
	})

	return result
end

local Statusline = {}

local function not_nil(v)
	return v and true or false
end

function Statusline.active()
	-- local ft = vim.bo.filetype
	-- local lineinfo = ft == "alpha"
	--   and ""
	--   or "%l:%c"

	return table.concat(vim.tbl_filter(not_nil, {
		"%#StatusLine#",
		modes[vim.api.nvim_get_mode().mode],
		"%#StatusLine#",
		filepath(),
		filename(),
		git(),
		" %m%#StatusLine#",
		lsp(),
		"%=%#StatusLine#",
		vim.bo.filetype,
		" %l:%c %p%%%#StatusLine#",
	}))
end

function Statusline.inactive()
	return table.concat({
		"%#StatusLineNC#",
		-- modes[vim.api.nvim_get_mode().mode],
		" %F %m ",
	})
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
