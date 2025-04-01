-- Terminal pane/tab/window handler
return {
	"akinsho/toggleterm.nvim",
	keys = {
		{ "<leader>t", "<cmd>ToggleTerm<cr>" },
		{ "<esc>", [[<C-\><C-n>]], mode = "t", buffer = 0 },
		{ "<C-h>", "<cmd>wincmd h<cr>", mode = "t", buffer = 0 },
		{ "<C-j>", "<cmd>wincmd j<cr>", mode = "t", buffer = 0 },
		{ "<C-k>", "<cmd>wincmd k<cr>", mode = "t", buffer = 0 },
		{ "<C-l>", "<cmd>wincmd l<cr>", mode = "t", buffer = 0 },
	},
	event = "TermOpen",
	opts = { direction = "horizontal" },
	config = function()
		require("toggleterm").setup({ direction = "horizontal" })
	end,
}
