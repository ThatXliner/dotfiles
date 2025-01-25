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
-- -- Disable default Tab mapping
-- vim.g.copilot_no_tab_map = true
--
-- -- Map opt-tab to accept completion
-- vim.api.nvim_set_keymap("i", "<D-Tab>", 'copilot#Accept("")', { expr = true, silent = true, script = true })
