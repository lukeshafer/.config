return function()
  return {
    ------------------
    -- COLOR THEMES --
    ------------------
    {
      "Mofiqul/vscode.nvim",
      config = function()
        vim.cmd('colorscheme vscode')
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

        --vim.cmd('colorscheme github_dark_high_contrast')
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



    ---- OTHER COLOR SCHEMES ----
    { dir = "~/.config/lush_themes/stream.lua" }, -- custom theme
    "sainnhe/sonokai",
    {
      'rose-pine/neovim',
      name = 'rose-pine'
    },
    "folke/tokyonight.nvim",
    "EdenEast/nightfox.nvim",
    "sainnhe/everforest",
    "sainnhe/edge",
    "rebelot/kanagawa.nvim",
    "olimorris/onedarkpro.nvim",
    "tomasiser/vim-code-dark",
    { "catppuccin/nvim",                       name = "catppuccin" },
    { 'Everblush/nvim', name = 'everblush' },
    "Yazeed1s/oh-lucy.nvim",
    ------------------
  }
end
