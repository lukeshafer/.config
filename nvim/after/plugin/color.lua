HOME = os.getenv("HOME")
local dir = vim.fn.getcwd()

-- options: default, atlantis, andromeda, shusia, maia, espresso
vim.g.sonokai_better_performance = 1

-- DEFAULT COLORSCHEME
vim.cmd([[colorscheme OceanicNext]])

-- DIRECTORY-BASED SCHEMES
if dir == HOME .. "/repos/crmi-common" then
	vim.g.sonokai_style = "default"
	vim.cmd([[colorscheme sonokai]])
elseif dir == HOME .. "/repos/contact-integrations" then
	vim.g.sonokai_style = "espresso"
	vim.cmd([[colorscheme sonokai]])
elseif dir == HOME .. "/repos/crmi-web-to-case" then
	vim.g.sonokai_style = "andromeda"
	vim.cmd([[colorscheme sonokai]])
elseif dir == HOME .. "/repos/student-recruitment-integrations" then
	vim.g.sonokai_style = "shusia"
	vim.cmd([[colorscheme sonokai]])
elseif dir == HOME .. "/repos/crmi-source-to-salesforce-transformations" then
	vim.g.everforest_better_performance = 1
	vim.g.everforest_diagnostic_text_highlight = 1
	vim.g.everforest_background = "hard"
	vim.cmd([[colorscheme everforest]])
elseif dir == HOME .. "/.config" then
	vim.cmd([[colorscheme tokyonight]])
end
