return {
  "git@github.com:neovim/nvim-lspconfig",
  -- {
  -- 	"git@github.com:Mythos-404/xmake.nvim",
  -- 	lazy = true,
  -- 	event = "BufRead xmake.lua",
  -- 	config = true,
  -- 	dependencies = { "git@github.com:MunifTanjim/nui.nvim", "git@github.com:nvim-lua/plenary.nvim" },
  -- 	opts = {
  -- 		compile_command = {
  -- 			dir = '.'
  -- 		}
  -- 	},
  -- },

  "git@github.com:lewis6991/gitsigns.nvim",
  "git@github.com:ms-jpq/coq_nvim",
  "git@github.com:nvim-treesitter/nvim-treesitter",
  "git@github.com:Mofiqul/vscode.nvim.git",
  "git@github.com:nvim-tree/nvim-tree.lua",
  "git@github.com:tanvirtin/monokai.nvim",
  {
    "git@github.com:kylechui/nvim-surround",
    version = "*",             -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  {
    "git@github.com:ellisonleao/gruvbox.nvim",
    priority = 1000,
  },
  {
    "git@github.com:aznhe21/actions-preview.nvim.git",
    config = function()
      vim.keymap.set({ "v", "n" }, "gf", require("actions-preview").code_actions)
    end
  },
  "git@github.com:lukas-reineke/lsp-format.nvim.git",
  {
    "git@github.com:iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  "git@github.com:pierreglaser/folding-nvim.git",
  {
    'git@github.com:nvim-telescope/telescope.nvim',
    dependencies = { 'git@github.com:nvim-lua/plenary.nvim' }

  },
  "git@github.com:rktjmp/lush.nvim",
  "git@github.com:homodeluna/pracale.nvim",
  {
    "kylechui/nvim-surround",
    version = "*",             -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  }
}
