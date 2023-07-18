local zen_mode = require("zen-mode")

local function toggle_zen_mode()
	zen_mode.toggle({
		window = {
			width = 0.45,
		}
	})
end

vim.keymap.set("n", "<leader>z", toggle_zen_mode, { noremap = true })
