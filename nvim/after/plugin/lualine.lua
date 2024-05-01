local function formatMode(str)
	if str == "NORMAL" then
		return ""
	elseif str == "INSERT" then
		return ""
	elseif str == "VISUAL" or str == "V-LINE" or str == "V-BLOCK" then
		return "󰗧"
	elseif str == "COMMAND" then
		return ""
	else
		return str
	end
end

local filename = {
	"filename",
	symbols = { modified = "●", readonly = "[READONLY]" },
	path = 4,
}

require("lualine").setup({
	sections = {
		lualine_a = { { "mode", fmt = formatMode } },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { filename },
		lualine_x = { "encoding", "filetype" },
		lualine_y = {},
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { filename },
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	extensions = { "nvim-tree", "toggleterm", "man" },
})
