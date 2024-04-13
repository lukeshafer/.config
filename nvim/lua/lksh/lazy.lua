-- Ensure lazy is installed and install it
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

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

-- util for combining lua lists
local function combine_lists(listOfLists)
  local list = {}

  for _, l in ipairs(listOfLists) do
    vim.list_extend(list, l)
  end

  return list
end

-- actual lazy configuration
require("lazy").setup(combine_lists({
  require('lksh.plugins.colors')(),
  require('lksh.plugins.ui')(),
  require('lksh.plugins.tools')(),
  require('lksh.plugins.languages')(),
}))
