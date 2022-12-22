HOME = os.getenv("HOME")

vim.g.everforest_better_performance = 1
vim.g.everforest_diagnostic_text_highlight = 1
vim.g.everforest_background = "hard"
vim.cmd([[colorscheme everforest]])

-- options: default, atlantis, andromeda, shusia, maia, espresso
vim.g.sonokai_better_performance = 1

local dir = vim.fn.getcwd()

if dir == HOME .. "/repos/crmi-common" then
	vim.cmd([[colorscheme carbonfox]])
elseif dir == HOME .. "/repos/contact-integrations" then
	vim.cmd([[colorscheme nightfox]])
elseif dir == HOME .. "/repos/crmi-web-to-case" then
	vim.cmd([[colorscheme terafox]])
	--elseif dir == HOME .. "/.config" then
	--vim.cmd([[colorscheme tokyonight]])
end
