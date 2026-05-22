require("lint").linters_by_ft = {
	yaml = { "cfn_lint" },
}

vim.api.nvim_create_autocmd({"BufWritePost", "BufWinEnter", "TextChanged"}, {
  callback = function()
    require("lint").try_lint()
  end
})
