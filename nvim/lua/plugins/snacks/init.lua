-- ABOUTME: Core snacks.nvim quality-of-life modules.
-- ABOUTME: Enables the dashboard start screen and smooth scroll.

-- Scroll a percentage of the window height using native scroll keys so
-- snacks.scroll animates the view change. When move_cursor is set, the cursor
-- follows so it keeps its relative screen position.
local function scroll(view_key, cursor_key, pct, move_cursor)
  return function()
    local n = math.max(1, math.floor(vim.api.nvim_win_get_height(0) * pct))
    local seq = n .. view_key
    if move_cursor then
      seq = seq .. n .. cursor_key
    end
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(seq, true, false, true), "nx", false)
  end
end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = { enabled = true },
    scroll = {
      enabled = true,
      animate = {
        duration = { step = 10, total = 100 },
        easing = "inOutSine",
      },
    },
  },
  keys = {
    { "<C-k>", scroll("<C-y>", "k", 0.2, true), mode = { "n", "v", "x" }, desc = "Scroll up (small)" },
    { "<C-j>", scroll("<C-e>", "j", 0.2, true), mode = { "n", "v", "x" }, desc = "Scroll down (small)" },
    { "<C-y>", scroll("<C-y>", "k", 0.1, false), mode = { "n", "v", "x" }, desc = "Scroll up (tiny)" },
    { "<C-e>", scroll("<C-e>", "j", 0.1, false), mode = { "n", "v", "x" }, desc = "Scroll down (tiny)" },
  },
}