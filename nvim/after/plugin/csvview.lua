local ok, csvview = pcall(require, "csvview")
if not ok then
	return
end

csvview.setup()

vim.keymap.set("n", "<leader>cs", "<cmd>CsvViewToggle<cr>")
