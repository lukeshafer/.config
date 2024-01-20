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
--vim.cmd "color github_dark_high_contrast"

--vim.g.colors_name = "stream"

local function set_stream_colors()
  require('lush')(require('lush_theme.stream'))
end

vim.api.nvim_create_user_command('SetStreamColors', set_stream_colors, {})

local function reset_fonts()
  vim.cmd("highlight Comment gui=italic")
  vim.cmd("highlight Error gui=italic")
  vim.cmd("highlight String gui=italic")

  vim.cmd("highlight Function gui=bold")
  vim.cmd("highlight Type gui=bold")
  vim.cmd("highlight @type gui=bold")
  vim.cmd("highlight @field gui=bold")

  vim.cmd("highlight Keyword gui=italic,bold")
  vim.cmd("highlight Conditional gui=italic,bold")
  vim.cmd("highlight @keyword.function gui=italic,bold")
  vim.cmd("highlight @keyword.operator gui=italic,bold")
  --vim.cmd("highlight PreProc gui=italic,bold")
end
--reset_fonts()

--vim.cmd("color vscode")
vim.cmd("color kanagawa")
vim.api.nvim_create_user_command('ResetFonts', reset_fonts, {})
