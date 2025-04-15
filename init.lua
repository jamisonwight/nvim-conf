-- init.lua
-- Main entry point for Neovim configuration
-- Optimized for web development

-- Bootstrap lazy.nvim package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Basic Neovim options
-- More options are set in lua/core/options.lua
vim.g.mapleader = " " -- Set leader key to space
vim.g.maplocalleader = " "
vim.opt.termguicolors = true -- Enable true color support

-- Import core configurations
require("core")

-- Plugin specification
require("lazy").setup({
  -- Import plugin specifications from the plugins directory
  { import = "plugins" },
}, {
  install = {
    -- Try to load a colorscheme when starting an installation
    colorscheme = { "tokyonight", "habamax" },
  },
  ui = {
    -- A border for the lazy panel
    border = "rounded",
  },
  checker = {
    -- Automatically check for plugin updates
    enabled = true,
    notify = false, -- Don't notify about updates
    frequency = 86400, -- Check once a day
  },
  change_detection = {
    -- Automatically reload the config when files change
    enabled = true,
    notify = false, -- Don't notify about config changes
  },
  performance = {
    rtp = {
      -- Disable some built-in plugins we don't need
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et

