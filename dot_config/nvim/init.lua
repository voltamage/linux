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
  {
    'catppuccin/nvim', -- bare minimun catppuccin theme
    name = 'catppuccin',
    transparent_background = true,
    integrations = {
      gitsigns = true,
    },
    config = function()
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    config = true, -- run require('gitsigns').setup()
  },
  {
    'sindrets/diffview.nvim', -- vscode-like diff view
    dependencies = {
      'nvim-lua/plenary.nvim', -- common files
      'nvim-tree/nvim-web-devicons', -- icons library, enabled by default
    },
  },
})

vim.o.clipboard = 'unnamedplus' -- use system clipboard, worth checking exactly which
vim.o.mouse = 'a' -- enable mouse, across all modes? have to check
