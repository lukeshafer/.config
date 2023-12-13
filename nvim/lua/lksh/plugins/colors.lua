return function()
  return {
    ------------------
    -- COLOR THEMES --
    ------------------
    {
      "Mofiqul/vscode.nvim",
      config = function()
        --vim.cmd('colorscheme vscode')
      end,
    },
    "rktjmp/lush.nvim", -- colorscheme MAKER
    {
      'projekt0n/github-nvim-theme',
      config = function()
        require('github-theme').setup({
          options = {
            styles = {
              comments = 'italic',
              keywords = 'bold',
              types = 'italic,bold',
            }
          }
        })

        vim.cmd('colorscheme github_dark_high_contrast')
      end,
    },

    --{
    --'lunarvim/synthwave84.nvim',
    --config = function()
    --require 'synthwave84'.setup({
    --glow = {
    --error_msg = true,
    --type2 = true,
    --func = true,
    --keyword = true,
    --operator = false,
    --buffer_current_target = true,
    --buffer_visible_target = true,
    --buffer_inactive_target = true,
    --}
    --})
    --vim.cmd 'color synthwave84'
    --end,
    --},



    { dir = "~/.config/lush_themes/stream.lua" }, -- custom theme
    "shaunsingh/moonlight.nvim",
    "sainnhe/sonokai",
    "olivercederborg/poimandres.nvim",
    {
      'rose-pine/neovim',
      name = 'rose-pine'
    },
    ---- OTHER COLOR SCHEMES ----
    "folke/tokyonight.nvim",
    "EdenEast/nightfox.nvim",
    "frenzyexists/aquarium-vim",
    "sainnhe/everforest",
    "sainnhe/edge",
    "rebelot/kanagawa.nvim",
    "mhartington/oceanic-next",
    "savq/melange",
    "olimorris/onedarkpro.nvim",
    { "catppuccin/nvim",                       name = "catppuccin" },
    { 'embark-theme/vim',                      name = 'embark' },
    "rmehri01/onenord.nvim",
    { 'Everblush/nvim', name = 'everblush' },
    "Yazeed1s/oh-lucy.nvim",
    ------------------
  }
end
