return {
	"nvim-neo-tree/neo-tree.nvim",
	-- event = "BufEnter",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	cmd = { "Neotree" },
	keys = {
		{ "<leader>e", ":Neotree reveal<cr>", noremap = true },
		{ "<leader>b", ":Neotree buffers reveal<cr>", noremap = true },
		{ "<leader>g", ":Neotree git_status reveal<cr>", noremap = true },
	},
	config = function()
		require("neo-tree").setup({
			sort_case_insensitive = true,
			window = {
				position = "float",
				mappings = {
					["o"] = "open",
					["oc"] = "none",
					["od"] = "none",
					["og"] = "none",
					["om"] = "none",
					["on"] = "none",
					["os"] = "none",
					["ot"] = "none",
				},
			},
			filesystem = {
				filtered_items = {
					visible = false, -- when true, they will just be displayed differently than normal items
					hide_dotfiles = false,
					hide_gitignored = true,
					hide_hidden = true, -- only works on Windows for hidden files/directories
				},
			},
		})
	end,
}
