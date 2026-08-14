-- Statusline Modules

-- local mode_icons = {
-- 	-- normal = "%#MiniStatuslineModeNormal#  %#WhichKeyFloat#",
-- 	-- visual = "%#MiniStatuslineModeVisual# 󰗧 %#DiagnosticFloatingOk#",
-- 	-- insert = "%#MiniHipatternsTodo#  %#DiagnosticFloatingInfo#",
-- 	-- command = "%#MiniStatuslineModeCommand#  %#DiagnosticFloatingWarn#",
-- 	normal = "%#StatusLine# ",
-- 	visual = "%#Cursor#󰗧 ",
-- 	insert = "%#DiffText# ",
-- 	command = "%#IncSearch# ",
-- }

local mode_icons = {
	Normal = " ",
	Visual = "󰗧 ",
	Insert = " ",
	Command = " ",
}

local pl = {
	hard = { "", "" },
	soft = { "", "" },
	round = { "", "" },
	btm_angle = { "", "" },
	top_angle = { "", "" },
	thin_angle = { "", "" },
	flame = { "", "" },
	thin_flame = { "", "" },
	pixel_sm = { "", "" },
	pixel_lg = { "", "" },
	honeycomb_hrd = { "" },
	honeycomb_sft = { "" },
	trapezoid = { "", "" },
}

local mode_map = {
	["n"] = "Normal",
	["nt"] = "Normal",
	["no"] = "Normal",
	["v"] = "Visual",
	["V"] = "Visual",
	[""] = "Visual",
	["s"] = "Visual",
	["S"] = "Visual",
	[""] = "Visual",
	["i"] = "Insert",
	["ic"] = "Insert",
	["R"] = "Insert",
	["Rv"] = "Insert",
	["c"] = "Command",
	["cv"] = "Command",
	["ce"] = "Command",
	["r"] = "Command",
	["rm"] = "Command",
	["r?"] = "Command",
	["!"] = "Command",
	["t"] = "Command",
}

---@param name string
---@param contents string
---@param border string? "round" by default
local function blob(name, contents, border)
	local hl = string.format("%%#LKSHStatus%s#", name)
	local inv = string.format("%%#LKSHStatus%sInv#", name)
	local sep = pl[border] or pl.round

	return table.concat({
    " ",
		inv,
		sep[2] or "",
		hl,
		contents,
		inv,
		sep[1],
		"%#StatusLine#",
	})
end

local function filepath()
	-- local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.:h")
	local fpath = vim.fn.expand("%")

	if fpath == "" or fpath == "." then
		return " "
	end

	return blob("Filepath", string.format(" %%<%s ", fpath))
	--
	-- return table.concat({
	-- 	string.format(" %%<%s ", fpath),
	-- })
end

-- local function filename()
-- 	local fname = vim.fn.expand("%:t")
-- 	if fname == "" then
-- 		return ""
-- 	end
-- 	return fname .. " "
-- end

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

	return table.concat({
		"%#StatusLine#",
		errors,
		warnings,
		hints,
		info,
		"%#StatusLine#",
	})

	-- return errors .. warnings .. hints .. info .. "%#StatusLine#"
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

local function mode()
	local mode_name = mode_map[vim.api.nvim_get_mode().mode]
	return blob(mode_name, mode_icons[mode_name])
end

local GAP = " %m"

function Statusline.active()
	vim.api.nvim_set_hl(0, "StatusLine", { update = true, bg = "none", ctermbg = "none" })
	-- vim.api.nvim_set_hl(0, "NonText", { update = true, bg = "none", ctermbg = "none" })
	return table.concat(vim.tbl_filter(not_nil, {
		mode(),
		filepath(),
		-- filename(),
		git(),
		GAP,
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

---comment
---@param name string
---@param bg string
---@param opts vim.api.keyset.highlight?
local function set_statusline_hl(name, bg, opts)
	local hl_name = string.format("LKSHStatus%s", name)

	vim.api.nvim_set_hl(
		0,
		hl_name,
		vim.tbl_extend("force", opts or {}, {
			update = true,
			bg = bg,
		})
	)
	vim.api.nvim_set_hl(
		0,
		hl_name .. "Inv",
		vim.tbl_extend("force", opts or {}, {
			update = true,
			fg = bg,
			bg = "bg",
		})
	)
end

local function init_highlight_groups()
	set_statusline_hl("Normal", "#20364f")
	set_statusline_hl("Insert", "#d8eced", { fg = "black" })
	set_statusline_hl("Visual", "#f7d0f7", { fg = "black" })
	set_statusline_hl("Command", "#f4d3a8", { fg = "black" })
	set_statusline_hl("Filepath", "#8376e0", { bold = true })
end

function Statusline.init()
	init_highlight_groups()
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
