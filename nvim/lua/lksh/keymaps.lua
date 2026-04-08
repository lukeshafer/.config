local Keymaps = {}

---@param modes string|string[]
---@param lhs string
---@param rhs string|function
---@param opts? vim.keymap.set.Opts
function Keymaps.set_map(modes, lhs, rhs, opts)
	opts = opts or {}
	if opts.noremap == nil then
		opts.noremap = true
	end
	if opts.silent == nil then
		opts.silent = true
	end

	vim.keymap.set(modes, lhs, rhs, opts)
end

function Keymaps.init()
	-- CTRL Up/Down moves lines up/down
	Keymaps.set_map("n", "<C-Up>", ":m -2<CR>")
	Keymaps.set_map("n", "<C-k>", ":m -2<CR>")
	Keymaps.set_map("n", "<C-Down>", ":m +1<CR>")
	Keymaps.set_map("n", "<C-j>", ":m +1<CR>")
	-- ESC also clears highlighting
	Keymaps.set_map("n", "<leader><Esc>", ":noh<cr>")
	-- SPACE Up/Down/Left/Right moves to other window
	Keymaps.set_map("n", "<leader>k", "<C-w>k")
	Keymaps.set_map("n", "<leader>j", "<C-w>j")
	Keymaps.set_map("n", "<leader>h", "<C-w>h")
	Keymaps.set_map("n", "<leader>l", "<C-w>l")
	-- x deletes character but does not put in clipboard"
	Keymaps.set_map("n", "x", '"_x')
	Keymaps.set_map("n", "<leader>x", ":bprevious|bdelete #<cr>")
	Keymaps.set_map("n", "<leader>XX", ":bdelete!<cr>")
	-- Semicolon is also Colon
	Keymaps.set_map("n", ";", ":")
	-- Leader+Y copies to system clipboard
	Keymaps.set_map("n", "<leader>y", '"+y')
	Keymaps.set_map("v", "<leader>y", '"+y')
	Keymaps.set_map("n", "<leader>s", ":Inspect<cr>")
	-- Leader+T opens terminal in pane
	-- map("n", "<leader>t", ":belowright 15sp|term<cr>") -- WIP for no plugin

	Keymaps.set_map("n", "<leader>d", function()
		vim.diagnostic.open_float({ source = true })
	end)
	Keymaps.set_map("n", "<leader>q", vim.diagnostic.setloclist)

	--------VISUAL MODE---------
	-- Indenting keeps previous highlight
	vim.keymap.set("v", ">", ">gv")
	vim.keymap.set("v", "<", "<gv")

	vim.keymap.set("v", "<leader>s", "<Cmd>LSSortList<cr>")

	-- nvim terminal mappings
	-- Escape gets out of insert (in terminal)
	vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
end

return Keymaps
