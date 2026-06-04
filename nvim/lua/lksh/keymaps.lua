local Keymaps = {}

function Keymaps.init()
	-- CTRL Up/Down moves lines up/down
	vim.keymap.set("n", "<C-Up>", ":m -2<CR>", { desc = "Move line up" })
	vim.keymap.set("n", "<C-k>", ":m -2<CR>", { desc = "Move line up" })
	vim.keymap.set("n", "<C-Down>", ":m +1<CR>", { desc = "Move line down" })
	vim.keymap.set("n", "<C-j>", ":m +1<CR>", { desc = "Move line down" })

	vim.keymap.set(
		"n",
		"<leader><Esc>",
		"<cmd>lua vim.notify('Luke, use <C-l>',vim.log.levels.WARN)<cr>",
		{ desc = "Break bad habits" }
	)

	-- use <C-l>
	-- x deletes character but does not put in clipboard"
	vim.keymap.set("n", "x", '"_x', { desc = "Delete char (no yank)" })
	vim.keymap.set("n", "<leader>x", ":bprevious|bdelete #<cr>", { desc = "Close buffer" })
	vim.keymap.set("n", "<leader>XX", ":bdelete!<cr>", { desc = "Force close buffer" })
	-- Semicolon is also Colon
	vim.keymap.set("n", ";", ":", { desc = "Enter command mode" })
	-- Leader+Y copies to system clipboard
	vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
	-- vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
	vim.keymap.set("n", "<leader>s", ":Inspect<cr>", { desc = "Inspect highlight group" })
	vim.keymap.set("n", "<leader>lf", "<cmd>%lua<cr>", { desc = "Execute buffer as lua" })
	vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half-page up and center" })
	vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half-page down and center" })

	-- vim.keymap.set("n", "<Tab>", "<cmd>tabnext<cr>")
	-- vim.keymap.set("n", "<S-Tab>", "<cmd>tabprevious<cr>")
	-- Leader+T opens terminal in pane
	-- vim.keymap.set("n", "<leader>t", ":belowright 15sp|term<cr>") -- WIP for no plugin
	vim.keymap.set("n", "<leader>t", "<cmd>horiz term<cr>", { desc = "Open terminal (horizontal)" })
	vim.keymap.set("n", "<leader>T", "<cmd>vert term<cr>", { desc = "Open terminal (vertical)" })

	vim.keymap.set("n", "<leader>d", function()
		vim.diagnostic.open_float({ source = true })
	end, { desc = "Show diagnostic float with source" })
	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Send diagnostics to loclist" })

	vim.keymap.set("n", "<leader>c", "<cmd>colorscheme randomhue<cr>", { desc = "Randomize colorscheme" })

	vim.keymap.set("n", "n", "nzz", { desc = "Next search result and center" })
	vim.keymap.set("n", "N", "Nzz", { desc = "Prev search result and center" })

	--------VISUAL MODE---------
	-- Indenting keeps previous highlight
	vim.keymap.set("v", ">", ">gv", { desc = "Indent and reselect" })
	vim.keymap.set("v", "<", "<gv", { desc = "Dedent and reselect" })

	-- vim.keymap.set("v", "<leader>s", "<Cmd>LSSortList<cr>")

	-- nvim terminal mappings
	-- Escape gets out of insert (in terminal)
	vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal insert mode" })
end

return Keymaps
