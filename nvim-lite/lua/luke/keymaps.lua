local map_opts = { noremap = true, silent = true }

--------NORMAL MODE---------
vim.keymap.set("n", "<C-Up>", ":m -2<CR>", { desc = "Move line up" })
vim.keymap.set("n", "<C-k>", ":m -2<CR>", { desc = "Move line up" })
vim.keymap.set("n", "<C-Down>", ":m +1<CR>", { desc = "Move line down" })
vim.keymap.set("n", "<C-j>", ":m +1<CR>", { desc = "Move line down" })

vim.keymap.set("n", "<leader><Esc>", ":noh<cr>", { desc = "Hide highlighting" })

vim.keymap.set("n", "<leader>k", "<C-w>k", { desc = "Jump to window above" })
vim.keymap.set("n", "<leader>j", "<C-w>j", { desc = "Jump to window below" })
vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "Jump to window to left" })
vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "Jump to window to right" })

vim.keymap.set("n", "x", '"_x', { desc = "Remove character without yanking" })
vim.keymap.set("n", "<leader>x", ":bprevious|bdelete #<cr>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>XX", ":bdelete!<cr>", { desc = "Force delete buffer" })

vim.keymap.set("n", ";", ":", { desc = "Open command mode" })

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>s", ":Inspect<cr>", { desc = "Inspect treesitter symbol"})

-- map("n", "<leader>t", ":belowright 15sp|term<cr>")

vim.keymap.set("n", "<leader>d", function()
	vim.diagnostic.open_float({ source = true })
end, { desc = "Open diagnostics floating window" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

--------INSERT MODE---------
vim.keymap.set("i", "<C-h>", "<Left>", { desc = "Move cursor left" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "Move cursor up" })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "Move cursor right" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "Move cursor down" })

--------VISUAL MODE---------
vim.keymap.set("v", ">", ">gv", { desc = "Indenting keeps previous highlight" })
vim.keymap.set("v", "<", "<gv", { desc = "Indenting keeps previous highlight" })

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Escape gets out of insert (in terminal)" })
