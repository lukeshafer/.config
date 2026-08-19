-- Statusline Modules

local c256 = require("lksh.utils").c256

local mode_icons = {
	Normal = " ",
	Visual = "󰒉 ",
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

local function use_hl(name)
	return string.format("%%#LKSHStatus%s#", name)
end

---@param name string
---@param contents string
---@param border string? "round" by default
local function blob(name, contents, border)
	if #contents == 0 then
		return ""
	end

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
	return blob("Filepath", " %<%f %m")
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
		errors = string.format(" %s %i ", use_hl("LSPError"), count["errors"])
	end
	if count["warnings"] ~= 0 then
		warnings = string.format(" %s %i ", use_hl("LSPWarning"), count["warnings"])
	end
	if count["hints"] ~= 0 then
		hints = string.format(" %s %i ", use_hl("LSPHint"), count["hints"])
	end
	if count["info"] ~= 0 then
		info = string.format(" %s %i ", use_hl("LSPInfo"), count["info"])
	end

	return blob(
		"LSP",
		table.concat({
			errors,
			warnings,
			hints,
			info,
		})
	)
end

local function git()
	if not vim.b.minidiff_summary or not vim.b.minigit_summary then
		return ""
	end

	local added = ""
	if (vim.b.minidiff_summary.add or 0) > 0 then
		added = string.format(" %s+%i", use_hl("GitAdd"), vim.b.minidiff_summary.add)
	end

	local changed = ""
	if (vim.b.minidiff_summary.change or 0) > 0 then
		changed = string.format(" %s~%i", use_hl("GitChange"), vim.b.minidiff_summary.change)
	end

	local deleted = ""
	if (vim.b.minidiff_summary.delete or 0) > 0 then
		deleted = string.format(" %s-%i", use_hl("GitDelete"), vim.b.minidiff_summary.delete)
	end

	local result = table.concat({
		"  ",
		vim.b.minigit_summary.head_name,
		added,
		changed,
		deleted,
		" ",
	})

	return blob("Git", result)
end

local Statusline = {}

local function not_nil(v)
	return v and true or false
end

local function mode()
	local mode_name = mode_map[vim.api.nvim_get_mode().mode]
	return blob(mode_name, mode_icons[mode_name])
end

function Statusline.active()
	vim.api.nvim_set_hl(0, "StatusLine", { update = true, bg = "none", ctermbg = "none" })
	-- vim.api.nvim_set_hl(0, "NonText", { update = true, bg = "none", ctermbg = "none" })

	return table.concat(vim.tbl_filter(not_nil, {
		mode(),
		filepath(),
		git(),
		lsp(),
		"%=%#StatusLine#",
		vim.bo.filetype,
		" %l:%c %p%%%#StatusLine#",
	}))
end

function Statusline.inactive()
	return table.concat({
		blob("Inactive", mode_icons.Normal),
		blob("Inactive", " %F %m"),
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

function Statusline.init()
	local host_color = ({
		snerver = 29,
		lukelaptop = 103,
		gombertcrombert = 68,
		K4L7X4FWFW = 174,
	})[vim.fn.hostname()] or 203

	local dark = c256(236)
	local light = c256(231)

	set_statusline_hl("Normal", c256(239), { fg = light })
	set_statusline_hl("Insert", c256(12), { fg = "black" })
	set_statusline_hl("Visual", c256(225), { fg = "black" })
	set_statusline_hl("Command", c256(223), { fg = "black" })
	set_statusline_hl("Filepath", c256(host_color), { bold = true, fg = dark })

	set_statusline_hl("Inactive", c256(235))

	local git_color = c256(24)
	set_statusline_hl("Git", git_color, { fg = light })
	set_statusline_hl("GitAdd", git_color, { fg = "lightgreen" })
	set_statusline_hl("GitChange", git_color, { fg = "lightyellow" })
	set_statusline_hl("GitDelete", git_color, { fg = "lightred" })

	local lsp_color = c256(53)
	set_statusline_hl("LSP", lsp_color, { fg = light })
	set_statusline_hl("LSPError", lsp_color, { fg = "lightred", bold=true })
	set_statusline_hl("LSPWarning", lsp_color, { fg = "yellow", bold=true })
	set_statusline_hl("LSPHint", lsp_color, { fg = "lightgreen", bold=true })
	set_statusline_hl("LSPInfo", lsp_color, { fg = "lightblue", bold=true })

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
