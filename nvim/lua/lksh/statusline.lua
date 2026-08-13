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

local mode_info = {
	normal = {
		hl = "%#LKSHStatusNormal#",
		hl_inv = "%#LKSHStatusNormalInv#",
		sym = " ",
	},
	visual = {
		hl = "%#LKSHStatusVisual#",
		hl_inv = "%#LKSHStatusVisualInv#",
		sym = "󰗧 ",
	},
	insert = {
		hl = "%#LKSHStatusInsert#",
		hl_inv = "%#LKSHStatusInsertInv#",
		sym = " ",
	},
	command = {
		hl = "%#LKSHStatusCommand#",
		hl_inv = "%#LKSHStatusCommandInv#",
		sym = " ",
	},
}

local pl = {
	hrd_r = "",
	hrd_l = "",
	sft_r = "",
	sft_l = "",
	rnd_r = "",
	rnd_l = "",
	btm_angle_r = "",
	btm_angle_l = "",
	top_angle_r = "",
	top_angle_l = "",
	thin_angle_r = "",
	thin_angle_l = "",
	flame_r = "",
	flame_l = "",
	thin_flame_r = "",
	thin_flame_l = "",
	pxl_sm_r = "",
	pxl_sm_l = "",
	pxl_lg_r = "",
	pxl_lg_l = "",
	honeycomb_hrd = "",
	honeycomb_sft = "",
	trapezoid_r = "",
	trapezoid_l = "",
}

local mode_map = {
	["n"] = "normal",
	["nt"] = "normal",
	["no"] = "normal",
	["v"] = "visual",
	["V"] = "visual",
	[""] = "visual",
	["s"] = "visual",
	["S"] = "visual",
	[""] = "visual",
	["i"] = "insert",
	["ic"] = "insert",
	["R"] = "insert",
	["Rv"] = "insert",
	["c"] = "command",
	["cv"] = "command",
	["ce"] = "command",
	["r"] = "command",
	["rm"] = "command",
	["r?"] = "command",
	["!"] = "command",
	["t"] = "command",
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
	local m_info = mode_info[mode_map[vim.api.nvim_get_mode().mode]]

	return table.concat({
		m_info.hl_inv,
		pl.rnd_l,
		m_info.hl,
		m_info.sym,
		m_info.hl_inv,
		pl.rnd_r,
		"%#StatusLine#",
	})
end

local GAP = " %m"

function Statusline.active()
	vim.api.nvim_set_hl(0, "StatusLine", { update = true, bg = "none", ctermbg = "none" })
	-- vim.api.nvim_set_hl(0, "NonText", { update = true, bg = "none", ctermbg = "none" })
	return table.concat(vim.tbl_filter(not_nil, {
		mode(),
		filepath(),
		filename(),
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

local colors = {
	normal = "#20364f",
	insert = "#d8eced",
	visual = "#f7d0f7",
	command = "#f7e6d0",
}

local function init_highlight_groups()
	-- local ns_id = vim.api.nvim_create_namespace("")

	vim.api.nvim_set_hl(0, "LKSHStatusNormal", { update = true, fg = "fg", bg = colors.normal })
	vim.api.nvim_set_hl(0, "LKSHStatusNormalInv", { update = true, fg = colors.normal, bg = "bg" })

	vim.api.nvim_set_hl(0, "LKSHStatusInsert", { update = true, fg = "black", bg = colors.insert })
	vim.api.nvim_set_hl(0, "LKSHStatusInsertInv", { update = true, fg = colors.insert, bg = "bg" })

	vim.api.nvim_set_hl(0, "LKSHStatusVisual", { update = true, fg = "black", bg = colors.visual })
	vim.api.nvim_set_hl(0, "LKSHStatusVisualInv", { update = true, fg = colors.visual, bg = "bg" })

	vim.api.nvim_set_hl(0, "LKSHStatusCommand", { update = true, fg = "black", bg = colors.command })
	vim.api.nvim_set_hl(0, "LKSHStatusCommandInv", { update = true, fg = colors.command, bg = "bg" })
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
