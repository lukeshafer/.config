local Keymaps = {}

function Keymaps.init()
	-- CTRL Up/Down moves lines up/down
	vim.keymap.set("n", "<C-Up>", ":m -2<CR>")
	vim.keymap.set("n", "<C-k>", ":m -2<CR>")
	vim.keymap.set("n", "<C-Down>", ":m +1<CR>")
	vim.keymap.set("n", "<C-j>", ":m +1<CR>")
	-- ESC also clears highlighting
	vim.keymap.set("n", "<leader><Esc>", ":noh<cr>")
	-- x deletes character but does not put in clipboard"
	vim.keymap.set("n", "x", '"_x')
	vim.keymap.set("n", "<leader>x", ":bprevious|bdelete #<cr>")
	vim.keymap.set("n", "<leader>XX", ":bdelete!<cr>")
	-- Semicolon is also Colon
	vim.keymap.set("n", ";", ":")
	-- Leader+Y copies to system clipboard
	vim.keymap.set("n", "<leader>y", '"+y')
	vim.keymap.set("v", "<leader>y", '"+y')
	vim.keymap.set("n", "<leader>s", ":Inspect<cr>")
	vim.keymap.set("n", "ZR", "<cmd>LSRestart<cr>")
	vim.keymap.set("n", "<leader>lf", "<cmd>%lua<cr>")
	vim.keymap.set("n", "<C-u>", "<C-u>zz")
	vim.keymap.set("n", "<C-d>", "<C-d>zz")

	-- vim.keymap.set("n", "<Tab>", "<cmd>tabnext<cr>")
	-- vim.keymap.set("n", "<S-Tab>", "<cmd>tabprevious<cr>")
	-- Leader+T opens terminal in pane
	-- vim.keymap.set("n", "<leader>t", ":belowright 15sp|term<cr>") -- WIP for no plugin
	vim.keymap.set("n", "<leader>t", "<cmd>horiz term<cr>")
	vim.keymap.set("n", "<leader>T", "<cmd>vert term<cr>")

	vim.keymap.set("n", "<leader>d", function()
		vim.diagnostic.open_float({ source = true })
	end)
	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

	vim.keymap.set("n", "<leader>c", "<cmd>colorscheme randomhue<cr>")

	vim.keymap.set("n", "n", "nzz")
	vim.keymap.set("n", "N", "Nzz")

	--------VISUAL MODE---------
	-- Indenting keeps previous highlight
	vim.keymap.set("v", ">", ">gv")
	vim.keymap.set("v", "<", "<gv")

	-- vim.keymap.set("v", "<leader>s", "<Cmd>LSSortList<cr>")
	vim.keymap.set({ "v", "n" }, "<leader>gb", "<Cmd>LSBlame<cr>")

	-- nvim terminal mappings
	-- Escape gets out of insert (in terminal)
	vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
end

return Keymaps
