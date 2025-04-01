return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPost", "BufNewFile" },
	cmd = { "LspInfo", "LspInstall", "LspUninstall" },
	config = function()
		local lspconfig = require("lspconfig")
		local lsp_defaults = lspconfig.util.default_config

		lsp_defaults.capabilities =
			vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

		local onWSL = os.getenv("PC_CONTEXT") == "desktop-wsl"

		if onWSL then
			lspconfig.gdscript.setup({
				cmd = { "godot-wsl-lsp" },
			})
		else
			lspconfig.gdscript.setup({})
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP actions",
			callback = function(event)
				local opts = { noremap = true, silent = true, buffer = event.buf }

				vim.keymap.set("n", "<leader>f", function()
					require("conform").format({ timeout_ms = 2000, bufnr = event.buf, lsp_fallback = true })
				end, opts)
			end,
		})
	end,
}
