local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "git@github.com:folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

require("wang-lsp-config")
require("nvim-treesitter").setup {
  highlight = { enable = true },
}

require("nvim-tree").setup()
-- require('monokai').setup{ palette = require('monokai').soda }
local colorscheme = "pracale"
-- require("gruvbox")
require("pracale")
vim.cmd("colorscheme " .. colorscheme)

vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
