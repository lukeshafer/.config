function map(mode, shortcut, command, noremap)
	noremap = noremap or true
	vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = noremap })
end

-- leader is SPACE key
vim.g.mapleader = " "

--------NORMAL MODE---------
-- CTRL n opens new tab
map("n", "<C-n>", ":tabnew <CR>")
-- CTRL e toggles file browser
map("n", "<leader>e", ":NvimTreeToggle<CR>")
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
-- SPACE / toggles comment
map("n", "<leader>/", "<Plug>NERDCommenterToggle")
map("v", "<leader>/", "<Plug>NERDCommenterToggle<CR>gv")
-- TAB/SHIFT TAB changes buffer
map("n", "<Tab>", ":bn<cr>")
map("n", "<S-Tab>", ":bp<cr>")
map("n", "<leader>x", ":bd<cr>")
map("n", "<leader>XX", ":bd!<cr>")
-- Semicolon is also Colon
map("n", ";", ":")
-- Leader+Y copies to system clipboard
map("n", "<leader>y", '"+y')
map("v", "<leader>y", '"+y')

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
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
