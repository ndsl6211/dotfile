local function init()
  local neoscroll = require('neoscroll')
  local keymap = {
    ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 100, easing = 'sine' }) end,
    ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 100, easing = 'sine' }) end,

    ["<C-k>"] = function() neoscroll.scroll(-0.2, { move_cursor = true, duration = 50, easing = 'sine' }) end,
    ["<C-j>"] = function() neoscroll.scroll(0.2, { move_cursor = true, duration = 50, easing = 'sine' }) end,
    ["<C-y>"] = function() neoscroll.scroll(-0.1, { move_cursor = false, duration = 100, easing = 'cubic' }) end,
    ["<C-e>"] = function() neoscroll.scroll(0.1, { move_cursor = false, duration = 100, easing = 'cubic' }) end,

    ["zt"]    = function() neoscroll.zt({ half_win_duration = 100 }) end,
    ["zz"]    = function() neoscroll.zz({ half_win_duration = 100 }) end,
    ["zb"]    = function() neoscroll.zb({ half_win_duration = 100 }) end,
  }
  local modes = { 'n', 'v', 'x' }
  for key, func in pairs(keymap) do
    vim.keymap.set(modes, key, func)
  end
end

return {
  "karb94/neoscroll.nvim",
  config = function()
    init()
  end
}
