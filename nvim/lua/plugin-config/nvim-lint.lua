require("lint").linters_by_ft = {
	--javascript = { "eslint" },
	--astro = { "eslint_d" },
	--typescript = { "eslint" },
	--svelte = { "eslint" },
	--tsx = { "eslint" },
	--jsx = { "eslint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
