-- Packages I have that can (maybe) be replaced by mini.nvim
--
-- lazy
--    mini.deps
--
-- nvim-cmp
--    mini.completion
--
-- snippet stuff
--    mini.snippets
--
-- [x]lualine
--    mini.statusline
--
-- telescope
--    mini.fuzy
--
-- diffview.nvim
-- gitsigns.nvim
--    mini.diff (maybe mini.git too)
--
-- [x]nvim-autopairs
--    mini.pairs
--
-- [x]nvim-surround
--    mini.surround
--
-- [x]indent-blankline
--    mini.indentscope
--
-- [x]nvim-web-devicons
--    mini.icons
--
-- [x]neo-tree
--    mini.files
--
-- vim-illuminate
--    mini.cursorword
--
-- nvim-highlight-colors
--

-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
-- local path_package = vim.fn.stdpath("data") .. "/site/"
-- local mini_path = path_package .. "pack/deps/start/mini.nvim"
-- if not vim.loop.fs_stat(mini_path) then
-- 	vim.cmd('echo "Installing `mini.nvim`" | redraw')
-- 	local clone_cmd = {
-- 		"git",
-- 		"clone",
-- 		"--filter=blob:none",
-- 		"https://github.com/echasnovski/mini.nvim",
-- 		mini_path,
-- 	}
-- 	vim.fn.system(clone_cmd)
-- 	vim.cmd("packadd mini.nvim | helptags ALL")
-- 	vim.cmd('echo "Installed `mini.nvim`" | redraw')
-- end
--
-- -- Set up 'mini.deps' (customize to your liking)
-- require("mini.deps").setup({ path = { package = path_package } })
--
-- --
--
-- local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
--
-- now(function()
-- 	add({
-- 		source = "rose-pine/neovim",
-- 		name = "rose-pine",
-- 	})
--
-- 	vim.cmd("color rose-pine-main")
-- end)
--
-- --
--
-- later(function()
-- 	add({
--     -- Formatter management
-- 		source = "stevearc/conform.nvim",
-- 	})
--
--
-- end)
