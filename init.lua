local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"git@github.com:folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"git@github.com:neovim/nvim-lspconfig",
	{
		"Mythos-404/xmake.nvim",
		lazy = true,
		event = "BufReadPost xmake.lua",
		config = true,
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {
			compile_command = {
				dir = '.'
			}
		},
	},

	"git@github.com:lewis6991/gitsigns.nvim",
	"git@github.com:ms-jpq/coq_nvim",
	"git@github.com:nvim-treesitter/nvim-treesitter",
	"git@github.com:Mofiqul/vscode.nvim.git",
	"git@github.com:nvim-tree/nvim-tree.lua",
	"git@github.com:tanvirtin/monokai.nvim",
	{
		"git@github.com:kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end
	},
	{
		"git@github.com:ellisonleao/gruvbox.nvim",
		priority = 1000 ,
	}

})

require("wang-lsp-config")
require("nvim-treesitter").setup {
	highlight = {enable = true}
}

require("nvim-tree").setup()
-- require('monokai').setup{ palette = require('monokai').soda }
local colorscheme = "gruvbox"
require("gruvbox")
vim.cmd("colorscheme " .. colorscheme)
