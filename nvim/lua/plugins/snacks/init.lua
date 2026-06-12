-- ABOUTME: Core snacks.nvim quality-of-life modules.
-- ABOUTME: Enables the dashboard, indent guides, smooth scroll, and terminal.

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

-- Toggle a bottom terminal that keeps a fixed side. When the paired terminal is
-- visible, this one splits to `side` of it; otherwise it opens as a full-width
-- bottom split. The side is re-resolved on every open so it never depends on the
-- order the two terminals were opened in.
local function toggle_term(my_count, other_count, side)
  return function()
    local terminal = require("snacks.terminal")
    local mine = terminal.get(nil, { count = my_count, create = false })
    if mine and mine:valid() then
      mine:hide()
      return
    end
    local other = terminal.get(nil, { count = other_count, create = false })
    local win
    if other and other:win_valid() then
      win = { relative = "win", win = other.win, position = side, width = 0.5 }
    else
      win = { position = "bottom", height = 0.4 }
    end
    if mine then
      mine.opts.win = win.win
      mine.opts.relative = win.relative or "editor"
      mine.opts.position = win.position
      mine.opts.width = win.width
      mine.opts.height = win.height
      mine:show()
    else
      terminal.toggle(nil, { count = my_count, win = win })
    end
  end
end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = { enabled = true },
    indent = {
      indent = { char = "▍" },
      scope = { char = "→" },
    },
    scroll = {
      enabled = true,
      animate = {
        duration = { step = 10, total = 100 },
        easing = "inOutSine",
      },
    },
    terminal = {},
  },
  keys = {
    { [[<c-\>]], toggle_term(1, 2, "left"), mode = { "n", "t" }, desc = "Toggle terminal (left)" },
    { "<C-]>", toggle_term(2, 1, "right"), mode = { "n", "t" }, desc = "Toggle terminal (right)" },

    { "<C-k>", scroll("<C-y>", "k", 0.2, true), mode = { "n", "v", "x" }, desc = "Scroll up (small)" },
    { "<C-j>", scroll("<C-e>", "j", 0.2, true), mode = { "n", "v", "x" }, desc = "Scroll down (small)" },
    { "<C-y>", scroll("<C-y>", "k", 0.1, false), mode = { "n", "v", "x" }, desc = "Scroll up (tiny)" },
    { "<C-e>", scroll("<C-e>", "j", 0.1, false), mode = { "n", "v", "x" }, desc = "Scroll down (tiny)" },

    { "<leader>iblt", function() vim.g.snacks_indent = vim.g.snacks_indent == false end, desc = "Toggle indent guides" },
  },
}
