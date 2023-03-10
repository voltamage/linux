vim.g.mapleader = ' ' -- set <space> as leader key

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim' -- lazy plugin manager bootstrap
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({ -- activate lazy plugin manager
'tpope/vim-fugitive',
{
    'catppuccin/nvim', -- bare minimun catppuccin theme
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        --transparent_background = true,
        term_colors = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          lsp_trouble = true,
          mason = true,
          native_lsp = {
            enabled = true,
          },
	  nvimtree = true,
          telescope = true,
          treesitter = true,
	  ts_rainbow2 = true,
        },
      })
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = true, -- run require('gitsigns').setup()
    -- config = function()
    --   require("gitsigns").setup({
    --     })
    -- end,
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require("gitsigns").setup({
        current_line_blame = true,
        })
    end,
  },
  {
    'sindrets/diffview.nvim', -- vscode-like diff view
    dependencies = {
      'nvim-lua/plenary.nvim', -- common files
      'nvim-tree/nvim-web-devicons', -- icons library, enabled by default
    },
  },
  {
    'numToStr/Comment.nvim', -- vscode-like diff view
    config = true, -- run require('gitsigns').setup()
  },
  -- {
  --   'folke/trouble.nvim', -- vscode-like diff view
  --   dependencies = {
  --     'nvim-tree/nvim-web-devicons', -- icons library, enabled by default
  --     --'folke/lsp-colors.nvim', -- for colorschemes that aren't LSP ready
  --   },
  --   config = true, -- run require('gitsigns').setup()
  -- },
  {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim', -- vscode-like diff view
    config = function()
      require('lsp_lines').setup()
      vim.diagnostic.config({
        virtual_text = false,
      })
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { -- ripgrep and fd binaries as well
      'nvim-tree/nvim-web-devicons', -- icons library, enabled by default
    },
    config = true, -- run require('gitsigns').setup()
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { -- ripgrep and fd binaries as well
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
      'nvim-tree/nvim-web-devicons', -- icons library, enabled by default
      'nvim-treesitter/nvim-treesitter',
    },
    config = true, -- run require('gitsigns').setup()
  },
  {
    'mrjones2014/legendary.nvim',
    dependencies = { -- ripgrep and fd binaries as well
      'nvim-telescope/telescope.nvim',
      'stevearc/dressing.nvim',
    },
    config = true, -- run require('gitsigns').setup()
  },
--  {
--    'folke/todo-comments.nvim',
--    dependencies = { -- ripgrep as well
--      'nvim-lua/plenary.nvim',
--      'nvim-telescope/telescope.nvim',
--      'folke/trouble.nvim',
--    },
--  },require("lazy").setup({
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },
  -- {
  --   'pwntester/octo.nvim',
  --   config = true, -- run require('gitsigns').setup()
  --   dependencies = { -- including github-cli
  --     'nvim-tree/nvim-web-devicons',
  --     'nvim-lua/plenary.nvim',
  --     'nvim-telescope/telescope.nvim',
  --   },
  -- },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter').setup({'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'})
    end,
  },
  {
    'HiPhish/nvim-ts-rainbow2',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require("nvim-treesitter.configs").setup {
        rainbow = {
          enable = true,
          query = 'rainbow-parens',
          strategy = require 'ts-rainbow.strategy.global',
        },
      }
    end,
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    dependencies = {
      -- LSP Support
      'neovim/nvim-lspconfig',             -- Required
      'williamboman/mason.nvim',           -- Optional
      'williamboman/mason-lspconfig.nvim', -- Optional

      -- Autocompletion
      'hrsh7th/nvim-cmp',         -- Required
      'hrsh7th/cmp-nvim-lsp',     -- Required
      'hrsh7th/cmp-buffer',       -- Optional
      'hrsh7th/cmp-path',         -- Optional
      'saadparwaiz1/cmp_luasnip', -- Optional
      'hrsh7th/cmp-nvim-lua',     -- Optional

    -- Snippets
      'L3MON4D3/LuaSnip',             -- Required
      'rafamadriz/friendly-snippets', -- Optional
    },
    config = function()
      local lsp = require('lsp-zero').preset({
        name = 'minimal',
        set_lsp_keymaps = true,
        manage_nvim_cmp = true,
        suggest_lsp_servers = true,
      })
      lsp.nvim_workspace() -- (Optional) Configure lua language server for neovim
      lsp.setup()
    end,
  },
  defaults = {
  lazy = true, -- should plugins be lazy-loaded?
  version = "*", -- use "*" to try installing the latest stable versions of plugins
  },
})

vim.o.clipboard = 'unnamedplus' -- use system clipboard, worth checking exactly which
vim.o.mouse = 'a' -- enable mouse, across all modes? have to check
vim.o.number = true                           -- set numbered lines
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.wrap = false -- functioning?
-- BUG test this thing
