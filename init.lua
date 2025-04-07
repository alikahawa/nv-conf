vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.local/share/nvim/plugged')
Plug('ThePrimeagen/vim-be-good')
vim.call('plug#end')

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  {
    'lervag/vimtex',
    config = function()
      vim.g.vimtex_view_method = 'skim'  -- Use Skim as the PDF viewer
      vim.g.vimtex_view_skim_sync = 1
      vim.g.vimtex_view_skim_activate = 1
    end
  },
  { import = "plugins" },
}, lazy_config)

require('markview').setup({
  latex = {
    enable = true,
    blocks = { enable = true },
    inlines = { enable = true },
    symbols = { enable = true },
  },
})

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

-- vim.opt.termguicolors = false

vim.schedule(function()
  require "mappings"
end)
