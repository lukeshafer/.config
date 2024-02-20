return function()
  return {
    ------------------
    --  LANGUAGES   --
    ------------------
    --Languages without LSP config
    "lankavitharana/ballerina-vim",
    "architect/vim-plugin",
    --"rescript-lang/vim-rescript",
    "nkrkv/nvim-treesitter-rescript",
    {
      "ckipp01/nvim-jenkinsfile-linter",
      dependencies = { "nvim-lua/plenary.nvim" }
    },

    -- LSPConfig Alternatives
    --{
    --"pmizio/typescript-tools.nvim",
    --dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    --opts = {},
    --},
    -- Formatters and Linters
    -- ( INFO: null-ls is no longer maintained, needs replacing )
    "jose-elias-alvarez/null-ls.nvim",

    -- LSP Support
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        {
          "SmiteshP/nvim-navbuddy",
          dependencies = {
            "SmiteshP/nvim-navic",
            "MunifTanjim/nui.nvim"
          },
          opts = { lsp = { auto_attach = true } }
        }
      },

    },
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    -- Autocompletion
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",

    -- Snippets
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
  }
end
