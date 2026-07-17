local ok, markview = pcall(require, "markview")
if not ok then
	return
end

markview.setup({
	preview = {
		icon_provider = "mini",
	},
})

vim.keymap.set("n", "<leader>m", "<CMD>Markview<CR>", { desc = "Toggles `markview` previews globally."})
