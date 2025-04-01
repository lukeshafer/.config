return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
	opts = {
		sections = {
			lualine_a = {
				{
					"mode",
					fmt = function(str)
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
					end,
				},
			},
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = {
				{
					"filename",
					symbols = { modified = "●", readonly = "[READONLY]" },
					path = 4,
				},
			},
			lualine_x = { "encoding", "filetype" },
			lualine_y = {},
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				{
					"filename",
					symbols = { modified = "●", readonly = "[READONLY]" },
					path = 4,
				},
			},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		extensions = { "nvim-tree", "toggleterm", "man" },
	},
}
