-- 初始化nvim
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
require("wang-highlight-glog")
require("wang-keymaps")

require("nvim-treesitter").setup {
  highlight = {
    enable = true,
    disable = function(lang, bufnr)
      -- Disable in large C++ buffers
      return lang == "cpp" and vim.api.nvim_buf_line_count(bufnr) > 50000
    end,
  },
}

require("nvim-tree").setup()
require("refactoring").setup()

-- 设置主题
local colorscheme = "pracale"
vim.opt.rtp:prepend("~/src/pracale.nvim")
require("pracale")
vim.cmd("colorscheme " .. colorscheme)

-- 折叠
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99

-- tab
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
