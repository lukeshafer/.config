-- Statusline Modules

local component_separators = { left = "", right = "" }
local section_separators = { left = "", right = "" }

local mode_icons = {
	normal = " ",
	visual = "󰗧 ",
	insert = " ",
	command = " ",
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

	return string.format(" %s %s ", modes[current_mode], component_separators.left)
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
		errors = "Error",
		warnings = "Warn",
		info = "Info",
		hints = "Hint",
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

	return errors .. warnings .. hints .. info .. "%#StatusLineNC#"
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
	local git_info = vim.b.gitsigns_status_dict
	if not git_info or git_info.head == "" then
		return ""
	end
	local added = git_info.added and ("%#GitSignsAdd#+" .. git_info.added .. " ") or ""
	local changed = git_info.changed and ("%#GitSignsChange#~" .. git_info.changed .. " ") or ""
	local removed = git_info.removed and ("%#GitSignsDelete#-" .. git_info.removed .. " ") or ""
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
		"%#StatusLineNC#",
		added,
		changed,
		removed,
		" ",
		"%#GitSignsAdd# ",
		git_info.head,
		" %#StatusLineNC#",
		component_separators.left,
	})
end

Statusline = {}

Statusline.active = function()
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

vim.cmd(
	[[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  augroup END
]],
	false
)
