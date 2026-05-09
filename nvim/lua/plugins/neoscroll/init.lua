local function init()
  local neoscroll = require('neoscroll')
  local keymap = {
    ["<C-u>"] = { func = function() neoscroll.ctrl_u({ duration = 100, easing = 'sine' }) end, desc = "Scroll half-page up" },
    ["<C-d>"] = { func = function() neoscroll.ctrl_d({ duration = 100, easing = 'sine' }) end, desc = "Scroll half-page down" },

    ["<C-k>"] = { func = function() neoscroll.scroll(-0.2, { move_cursor = true, duration = 50, easing = 'sine' }) end, desc = "Scroll up (small)" },
    ["<C-j>"] = { func = function() neoscroll.scroll(0.2, { move_cursor = true, duration = 50, easing = 'sine' }) end, desc = "Scroll down (small)" },
    ["<C-y>"] = { func = function() neoscroll.scroll(-0.1, { move_cursor = false, duration = 100, easing = 'cubic' }) end, desc = "Scroll up (tiny)" },
    ["<C-e>"] = { func = function() neoscroll.scroll(0.1, { move_cursor = false, duration = 100, easing = 'cubic' }) end, desc = "Scroll down (tiny)" },

    ["zt"]    = { func = function() neoscroll.zt({ half_win_duration = 100 }) end, desc = "Scroll cursor to top" },
    ["zz"]    = { func = function() neoscroll.zz({ half_win_duration = 100 }) end, desc = "Scroll cursor to center" },
    ["zb"]    = { func = function() neoscroll.zb({ half_win_duration = 100 }) end, desc = "Scroll cursor to bottom" },
  }
  local modes = { 'n', 'v', 'x' }
  for key, mapping in pairs(keymap) do
    vim.keymap.set(modes, key, mapping.func, { desc = mapping.desc })
  end
end

return {
  "karb94/neoscroll.nvim",
  config = function()
    init()
  end
}
