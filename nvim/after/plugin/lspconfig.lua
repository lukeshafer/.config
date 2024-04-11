local lspconfig = require("lspconfig")
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities =
    vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

local onWSL = os.getenv("PC_CONTEXT") == "desktop-wsl"

if onWSL then
  lspconfig.gdscript.setup({
    cmd = { "godot-wsl-lsp", },
  })
else
  lspconfig.gdscript.setup({})
end

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
    vim.keymap.set("n", "<leader>f", function()
      require("conform").format({
        timeout_ms = 2000,
        bufnr = event.buf,
        lsp_fallback = true
      })
    end, { noremap = true, silent = true, buffer = event.buf })
  end,
})

vim.fn.sign_define("DiagnosticSignError", {
  texthl = "DiagnosticSignError",
  text = "✘",
  numhl = "",
})

vim.fn.sign_define("DiagnosticSignWarn", {
  texthl = "DiagnosticSignWarn",
  text = "▲",
  numhl = "",
})

vim.fn.sign_define("DiagnosticSignHint", {
  texthl = "DiagnosticSignHint",
  text = "⚑",
  numhl = "",
})

vim.fn.sign_define("DiagnosticSignInfo", {
  texthl = "DiagnosticSignInfo",
  text = "",
  numhl = "",
})
