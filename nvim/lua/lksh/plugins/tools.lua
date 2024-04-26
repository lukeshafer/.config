return function()
  local tools = {
    ------------------
    --     TOOLS    --
    ------------------
    { "numToStr/Comment.nvim", opts = {},             lazy = false },

    -- color picker
    {
      "uga-rosa/ccc.nvim",
      event = "VeryLazy",
      config = function()
        require("ccc").setup({})
        vim.api.nvim_set_keymap("n", "cp", ":CccPick<CR>", { noremap = true })
      end,
    },

    -- auto-create brackets/parentheses
    { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },

    -- autoclose/rename html tags
    {
      "windwp/nvim-ts-autotag",
      event = "InsertEnter",
      config = function()
        require("nvim-ts-autotag").setup()
      end,
    },

    -- fuzzy finder
    { "nvim-telescope/telescope.nvim", lazy = true },

    -- Terminal pane/tab/window handler
    { "akinsho/toggleterm.nvim",       event = "VeryLazy" },

    -- git diff viewer
    {
      "sindrets/diffview.nvim",
      event = "VeryLazy",
      dependencies = "nvim-lua/plenary.nvim",
    },

    -- move and jump to spots in code quickly
    {
      "ggandor/leap.nvim",
      event = "BufEnter",
      config = function()
        require("leap").add_default_mappings()
      end,
    },

    -- file explorer
    { "nvim-tree/nvim-tree.lua", event = "VeryLazy", dependencies = { "nvim-tree/nvim-web-devicons" } },

    -- tools for surrounding text
    {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
        require("nvim-surround").setup({})
      end,
    },

    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      config = function()
        require("ts_context_commentstring").setup({
          languages = {
            javascript = {
              __default = "// %s",
              jsx_element = "{/* %s */}",
              jsx_fragment = "{/* %s */}",
              jsx_attribute = "// %s",
              comment = "// %s",
            },
          },
        })
      end,
    },
  }

  return tools
end
