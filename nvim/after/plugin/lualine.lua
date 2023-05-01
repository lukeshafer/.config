local function neovim()
	return "Neovim"
end

require("lualine").setup({
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = {
			{
				"filename",
				symbols = {
					modified = '●',
					readonly = '[READONLY]'
				}
			}
		},
		lualine_x = { "encoding", "filetype" },
		lualine_y = { neovim },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	extensions = { "nvim-tree", "toggleterm", "man" },
})
