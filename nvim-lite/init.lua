-- Bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Installation of plugins
require("lazy").setup({
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },

  -- Autocompletion
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "saadparwaiz1/cmp_luasnip" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-nvim-lua" },

  -- Snippets
  { "L3MON4D3/LuaSnip" },
  { "rafamadriz/friendly-snippets" },

  { "windwp/nvim-autopairs",            event = "InsertEnter", opts = {} },
  { "nvim-telescope/telescope.nvim",    lazy = true, 
			dependencies = "nvim-lua/plenary.nvim",
},
  { "akinsho/toggleterm.nvim",          event = "VeryLazy" },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
})

HOME = os.getenv("HOME")

-- Editor Settings
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.termguicolors = true

-- vim.opt.tCo = 256
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.backupdir = HOME .. "/.vim/backup"
vim.opt.dir = HOME .. "/.vim/swapfiles"
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
vim.opt.mouse = "a"
vim.opt.cursorline = true

vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.foldcolumn = "1"

local fcs = vim.opt.fillchars:get()
local foldopen = fcs.foldopen or "-"
local foldclose = fcs.foldclose or "+"

-- Stolen from Akinsho
local function get_fold(lnum)
  if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then
    return " "
  end
  return vim.fn.foldclosed(lnum) == -1 and foldopen or foldclose
end

_G.get_statuscol = function()
  return "%s%l " .. get_fold(vim.v.lnum) .. " "
end

vim.o.statuscolumn = "%!v:lua.get_statuscol()"

local function map(mode, shortcut, command, noremap)
  noremap = noremap or true
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = noremap })
end

-- leader is SPACE key
vim.g.mapleader = " "

--------NORMAL MODE---------
-- CTRL n opens new tab
map("n", "<C-n>", ":tabnew <CR>")
-- CTRL e toggles file browser
-- CTRL Up/Down moves lines up/down
map("n", "<C-Up>", ":m -2<CR>")
map("n", "<C-k>", ":m -2<CR>")
map("n", "<C-Down>", ":m +1<CR>")
map("n", "<C-j>", ":m +1<CR>")
-- ESC also clears highlighting
map("n", "<leader><Esc>", ":noh<cr>")
-- SPACE Up/Down/Left/Right moves to other window
map("n", "<leader>k", "<C-w>k")
map("n", "<leader>j", "<C-w>j")
map("n", "<leader>h", "<C-w>h")
map("n", "<leader>l", "<C-w>l")
-- x deletes character but does not put in clipboard"
map("n", "x", '"_x')
-- TAB/SHIFT TAB changes buffer
map("n", "<leader>x", ":bprevious|bdelete #<cr>")
map("n", "<leader>XX", ":bdelete!<cr>")
-- Semicolon is also Colon
map("n", ";", ":")
-- Leader+Y copies to system clipboard
map("n", "<leader>y", '"+y')
map("v", "<leader>y", '"+y')
map("n", "<leader>s", ":Inspect<cr>")

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>d", function()
  vim.diagnostic.open_float({ source = true })
end, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

--------INSERT MODE---------
map("i", "<C-h>", "<Left>")
map("i", "<C-k>", "<Up>")
map("i", "<C-l>", "<Right>")
map("i", "<C-j>", "<Down>")

--------VISUAL MODE---------
--
-- CTRL + BRACKET wraps selected text in the bracket
map("v", "<C-9>", "c()<Esc>hp")
map("v", "<C-(>", "c()<Esc>hp")
-- Indenting keeps previous highlight
map("v", ">", ">gv")
map("v", "<", "<gv")

-- nvim terminal mappings
-- Escape gets out of insert (in terminal)
map("t", "<Esc>", "<C-\\><C-n>")


-- CMP
local cmp = require("cmp")

cmp.setup({
  sources = {
    { name = "path" },
    { name = "nvim_lsp", keyword_length = 0 },
    { name = "luasnip",  keyword_length = 1 },
    { name = "buffer",   keyword_length = 3 },
  },
  mapping = cmp.mapping.preset.insert({
    -- Enter key confirms completion item
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    -- Ctrl + y confirms completion item
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    -- Ctrl + space triggers completion menu
    ['<C-Space>'] = cmp.mapping.complete(),
    -- Tab and S-Tab move through completion menu
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

-- LSP CONFIG
local lspconfig = require("lspconfig")
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities =
    vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local opts = { noremap = true, silent = true, buffer = event.buf }

    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
    vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
    vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
    vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
    vim.keymap.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<cr>", opts)
  end,
})

-- MASON
local default_setup = function(server)
  lspconfig[server].setup {}
end

require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = {
    "tsserver",
  },
  handlers = {
    default_setup,
    tsserver = function()
      lspconfig.tsserver.setup({
        init_options = {
          preferences = {
            disableSuggestions = true,
          },
        },
      })
    end,
  },
})

-- TELESCOPE
local builtin = require("telescope.builtin")

require("telescope").setup({
  defaults = {
    file_ignore_patterns = { "node_modules", "dist", "build", ".git" },
    layout_strategy = 'vertical'
  },
  pickers = {
    find_files = {
      hidden = true,
    },
  },
})

vim.keymap.set("n", "ff", builtin.find_files, {})
vim.keymap.set("n", "fg", builtin.live_grep, {})
vim.keymap.set("n", "fb", builtin.buffers, {})
vim.keymap.set("n", "fh", builtin.help_tags, {})

-- TOGGLETERM
require("toggleterm").setup({
  direction = "horizontal",
})

vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>")

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
