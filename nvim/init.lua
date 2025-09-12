-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

require "lazy_setup"
require "polish"
vim.g.VM_leader = ";"
vim.g.VM_maps = {
  -- This changes the default Control Up/Down mapping
  -- to control+alt+up and control+alt+down
  ["Add Cursor Up"] = "<C-A-Up>",
  ["Add Cursor Down"] = "<C-A-Down>",
}
-- Put this in your `init.lua` or sourced Lua file
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Bryan.vim
-- =================================================
-- ____                               _
-- |  _ \                             (_)
-- | |_) |_ __ _   _  __ _ _ __ __   ___ _ __ ___
-- |  _ <| '__| | | |/ _` | '_ \\ \ / / | '_ ` _ \
-- | |_) | |  | |_| | (_| | | | |\ V /| | | | | | |
-- |____/|_|   \__, |\__,_|_| |_(_)_/ |_|_| |_| |_|
--              __/ |
--             |___/
-- ==================================================
-- This my custom Vim bindings, based off of the Colemak layout
-- Theoretically, you could adapt this to QWERTY, as
-- the main feature here is that the keys are re-mapped
-- (from traditional vim) to optimize for positions on the keyboard
-- itself. The thought process is that I'm already breaking tradition
-- by using Colemak, so if I am going slowly remember the positions
-- of the commands, I might as well make it ergonomic rather than
-- mnemonic.
-- As such, my mappings are based in groups of 4 characters in a row,
-- with different "semantic groups" being a different set of 4
-- letters shifted around the keyboard.
-- The right hand (dominant hand) will be designated to the majority
-- of movement
local bryan_vim = {
  -----------------------------------
  -- Right hand home-row: movement --
  -----------------------------------
  -- This movement keymap is also spatially shifted
  -- slightly right compared to the traditional
  -- Vim keymap on QWERTY, as Colemak doesn't have
  -- ; and ' on the home row right side
  -- but instead only '
  n = "h", -- left
  e = "j", -- down
  i = "k", -- up
  o = "l", -- right
  -- Shift modifiers for "big jumps" (words)
  N = "ge",
  O = "e",

  ---------------------------------------------
  -- Above right hand : yank/put + undo/redo  --
  ---------------------------------------------
  -- yank/put + undo/redo , in that order next to the ;[]
  -- on the Colemak keyboard
  j = "y", -- yank
  l = "p", -- put
  u = "u", -- undo (intentionally the same)
  y = "r", -- redo
  -----------------------------------------
  -- Left hand home-row: insertion modes --
  -----------------------------------------
  -- For the majority of your time in Vim, you will be in
  -- one of these 2 modes: insert or normal. I designated
  -- the left hand in the home row to choose the variety of
  -- insertion modes, according to each finger strength and
  -- the frequency of each mode. That is, assuming that the
  -- Strength of each finger is roughly (from strongest to weakest):
  -- index, middle, pinky, ring
  -- And the most common insert modes being (from most frequent to least frequent):
  -- insert, delete, append at new line, replace
  t = "i",
  s = "d",
  S = "dd",
  a = "o",
  r = "r", -- intentionally the same
  --------------
  -- Appendix --
  --------------
  -- -- (To the right of the left hand in the home row)
  -- d = "g",
  -- (To the left of the right hand in the home row)
  h = "n", -- To make search still work
  -- (bottom of the right hand in the home row)
  -- Similar to option + arrow
  k = "ge",
  m = "e",
  K = "gE",
  M = "E",
  -- (Above left hand)
  f = "F", -- find (intentionally the same)
  p = "f", -- find backwards
}

-- Ciao, for now

for from, to in pairs(bryan_vim) do
  -- Only affect normal and visual modes
  map({ "n", "v" }, from, to, opts)
end
-- -- Disable default Tab mapping
-- vim.g.copilot_no_tab_map = true
--
-- -- Map opt-tab to accept completion
-- vim.api.nvim_set_keymap("i", "<D-Tab>", 'copilot#Accept("")', { expr = true, silent = true, script = true })
