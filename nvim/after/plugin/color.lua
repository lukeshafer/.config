--HOME = os.getenv("HOME")
--local dir = vim.fn.getcwd()

--vim.g.everforest_better_performance = 1
--vim.g.everforest_diagnostic_text_highlight = 1
--vim.g.everforest_background = "hard"

---- options: default, atlantis, andromeda, shusia, maia, espresso
--vim.g.sonokai_better_performance = 1

require("rose-pine").setup({
	dark_variant = "moon",
})

-- DEFAULT COLORSCHEME
--vim.cmd([[colorscheme onedark_vivid]])
vim.opt.background = "dark"
vim.cmd([[colorscheme rose-pine]])

-- -- DIRECTORY-BASED SCHEMES
--if dir == HOME .. "/repos/crmi-common" then
--vim.g.sonokai_style = "default"
--vim.cmd([[colorscheme sonokai]])
--elseif dir == HOME .. "/repos/contact-integrations" then
--vim.g.sonokai_style = "espresso"
--vim.cmd([[colorscheme sonokai]])
--elseif dir == HOME .. "/repos/crmi-web-to-case" then
--vim.g.sonokai_style = "andromeda"
--vim.cmd([[colorscheme sonokai]])
--elseif dir == HOME .. "/repos/student-recruitment-integrations" then
--vim.g.sonokai_style = "shusia"
--vim.cmd([[colorscheme sonokai]])
--elseif dir == HOME .. "/repos/crmi-source-to-salesforce-transformations" then
--vim.cmd([[colorscheme rose-pine]])
--elseif dir == HOME .. "/.config" then
--vim.cmd([[colorscheme tokyonight]])
--end
