-- ABOUTME: Core snacks.nvim quality-of-life modules.
-- ABOUTME: Enables the dashboard start screen.
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = { enabled = true },
  },
}
