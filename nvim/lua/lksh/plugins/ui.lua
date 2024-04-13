local atWork = os.getenv("PC_CONTEXT") == "work"

return function()
  return {
    ------------------
    --  UI HELPERS  --
    ------------------
    -- treesitter, parses code for better colors
    "nvim-treesitter/nvim-treesitter",

    -- shows parent context, like the current function/method, at the top of code
    --{ "nvim-treesitter/nvim-treesitter-context", event = "VeryLazy" },

    "nvim-tree/nvim-web-devicons",

    -- status line, bottom
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons", opt = true }
    },

    -- highlights matches to the word under the cursor
    {
      "RRethy/vim-illuminate",
      event = "VeryLazy",
      config = function()
        require('illuminate').configure()
      end
    },

    -- git blame inline
    {
      "APZelos/blamer.nvim",
      event = "VeryLazy",
      config = function()
        vim.g.blamer_enabled = 1
      end
    },

    -- inline git helpers
    {
      'lewis6991/gitsigns.nvim',
      opts = {}
    },

    -- highlight hex color strings e.g. #CCCCFF
    -- text-gray-900
    {
      "brenoprata10/nvim-highlight-colors",
      config = function()
        require("nvim-highlight-colors").setup({
          render = "background", -- 'foreground' or 'background' or 'virtual'
          enable_named_colors = false,
          -- bg-blue-450
          enable_tailwind = true,
        })
      end
    },

    -- highlight todo comments, e.g. TODO:
    {
      "folke/todo-comments.nvim",
      dependencies = "nvim-lua/plenary.nvim",
      opts = {}
    },

    -- show indentation levels
    {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      opts = {}
    },

    -- notification API
    {
      'rcarriga/nvim-notify',
      config = function()
      end
    },

    ------------------
  }
end
