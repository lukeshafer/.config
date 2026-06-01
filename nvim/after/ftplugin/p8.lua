vim.bo.commentstring = "-- %s"

if not vim.treesitter.language.add("lua") then
	return vim.notify(
		string.format("Treesitter cannot load parser for language: %s", "lua"),
		vim.log.levels.INFO,
		{ title = "Treesitter" }
	)
end
vim.treesitter.start(0, "lua")
