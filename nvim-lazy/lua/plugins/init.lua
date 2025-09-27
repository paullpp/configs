-- lua/plugins/init.lua
return {
  -- Plugin manager manages itself
  { "folke/lazy.nvim", version = "*" },

  { "nvim-telescope/telescope.nvim", tag = "0.1.8", dependencies = { "nvim-lua/plenary.nvim" }, config = function() require("after.plugins.telescope") end },

  { "EdenEast/nightfox.nvim", config = function() require("after.plugins.colors") end },

  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = function() require("after.plugins.treesitter") end},
  { "nvim-treesitter/playground" },

  { "theprimeagen/harpoon" },
  { "mbbill/undotree" },
  { "tpope/vim-fugitive" },

  -- LSP & Mason
  { "neovim/nvim-lspconfig", config = function() require("after.plugins.lspzero") end },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "WhoIsSethDaniel/mason-tool-installer.nvim" },

  -- Autocompletion & Snippets
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "saadparwaiz1/cmp_luasnip" },
  { "L3MON4D3/LuaSnip" },

  -- UI / Appearance
  { "nvim-tree/nvim-web-devicons" }, -- optional icons
  { "lewis6991/gitsigns.nvim" },     -- git signs
  { "romgrk/barbar.nvim" },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("after.plugins.tabline")
    end
  },

  { "f-person/git-blame.nvim" },
  { "tpope/vim-commentary" },
}

