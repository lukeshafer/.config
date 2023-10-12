-- Favorite colorschemes
--
-- rose-pine
-- vscode
-- moonlight
-- poimandres
-- sonokai
-- 	 vim.g.sonokai_style =
-- 	 	'default' 	-- neutral colors
-- 	 	'atlantis' 	-- cooler, muted blues and greens. Feels deep ocean themed.
-- 	 	'andromeda' -- like atlantis but more blue than green. Feels space themed.
-- 	 	'shusia' 	-- reddish-purple background, muted
-- 	 	'maia' 		-- like atlantis, more green than blue. Feels somewhere between ocean and forest
-- 	 	'espresso'  -- reddish-brown, coffee vibes

vim.opt.background = "dark" -- sets light/dark for some colorschemes
--vim.g.sonokai_style = "shusia"
vim.cmd "color vscode"

--local lush = require('lush')
--local hsl = lush.hsl

--local sea_foam  = hsl(208, 100, 80) -- Vim has a mapping, <n>C-a and <n>C-x to
--local sea_crest = hsl(208, 90, 30)  -- increment or decrement integers, or
--local sea_deep  = hsl(208, 90, 10)  -- you can just type them normally.

--local theme = lush(function()
	--return {
		--Normal { bg = sea_deep, fg = sea_foam }, -- Goodbye gray, hello blue!
	--}
--end)
