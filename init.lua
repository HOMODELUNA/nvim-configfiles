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

-- require("nvim-treesitter.configs").setup {
--   highlight = {
--     enable = true,
--     disable = function(lang, bufnr)
--       -- Disable in large C++ buffers
--       return lang == "cpp" and vim.api.nvim_buf_line_count(bufnr) > 50000
--     end,
--   },
-- }

require("nvim-tree").setup()
-- require("refactoring").setup()

-- 设置主题
local colorscheme = "pracale"
vim.opt.rtp:prepend("~/src/pracale.nvim")
require("pracale")
vim.cmd("colorscheme " .. colorscheme)

-- 为crystal语言增添一种新的parser
-- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
-- parser_config.crystal = {
--   install_info = {
--     url = "https://github.com/crystal-lang-tools/tree-sitter-crystal",
--     files = { "src/parser.c", "src/scanner.c" },
--     branch = "main",
--   },
--   filetype = "cr",
-- }

-- 折叠
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99

-- tab
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
