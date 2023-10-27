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

--vim.g.colors_name = "stream"

local function set_stream_colors()
	require('lush')(require('lush_theme.stream'))
end

vim.api.nvim_create_user_command('SetStreamColors', set_stream_colors, {})
