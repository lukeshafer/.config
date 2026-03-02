local map_opts = { noremap = true, silent = true }

-- CTRL Up/Down moves lines up/down
vim.keymap.set("n", "<C-Up>", ":m -2<CR>", map_opts)
vim.keymap.set("n", "<C-k>", ":m -2<CR>", map_opts)
vim.keymap.set("n", "<C-Down>", ":m +1<CR>", map_opts)
vim.keymap.set("n", "<C-j>", ":m +1<CR>", map_opts)
-- ESC also clears highlighting
vim.keymap.set("n", "<leader><Esc>", ":noh<cr>", map_opts)
-- SPACE Up/Down/Left/Right moves to other window
vim.keymap.set("n", "<leader>k", "<C-w>k", map_opts)
vim.keymap.set("n", "<leader>j", "<C-w>j", map_opts)
vim.keymap.set("n", "<leader>h", "<C-w>h", map_opts)
vim.keymap.set("n", "<leader>l", "<C-w>l", map_opts)
-- x deletes character but does not put in clipboard"
vim.keymap.set("n", "x", '"_x', map_opts)
vim.keymap.set("n", "<leader>x", ":bprevious|bdelete #<cr>", map_opts)
vim.keymap.set("n", "<leader>XX", ":bdelete!<cr>", map_opts)
-- Semicolon is also Colon
vim.keymap.set("n", ";", ":", map_opts)
-- Leader+Y copies to system clipboard
vim.keymap.set("n", "<leader>y", '"+y', map_opts)
vim.keymap.set("v", "<leader>y", '"+y', map_opts)
vim.keymap.set("n", "<leader>s", ":Inspect<cr>", map_opts)
-- Leader+T opens terminal in pane
-- map("n", "<leader>t", ":belowright 15sp|term<cr>")

vim.keymap.set("n", "<leader>d", function()
	vim.diagnostic.open_float({ source = true })
end, map_opts)
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, map_opts) -- built in
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, map_opts) -- built in
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, map_opts)

--------INSERT MODE---------
-- vim.keymap.set("i", "<C-h>", "<Left>", map_opts)
-- vim.keymap.set("i", "<C-k>", "<Up>", map_opts)
-- vim.keymap.set("i", "<C-l>", "<Right>", map_opts)
-- vim.keymap.set("i", "<C-j>", "<Down>", map_opts)

--------VISUAL MODE---------
--
-- CTRL + BRACKET wraps selected text in the bracket
-- vim.keymap.set("v", "<C-9>", "c()<Esc>hp", map_opts)
-- vim.keymap.set("v", "<C-(>", "c()<Esc>hp", map_opts)
-- Indenting keeps previous highlight
vim.keymap.set("v", ">", ">gv", map_opts)
vim.keymap.set("v", "<", "<gv", map_opts)

-- nvim terminal mappings
-- Escape gets out of insert (in terminal)
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", map_opts)
