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

require("lazy").setup() -- activate lazy plugin manager
