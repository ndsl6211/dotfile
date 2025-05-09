return {
  'sphamba/smear-cursor.nvim',
  enabled = true,
  opts = {
    -- detailed configuration: https://github.com/sphamba/smear-cursor.nvim/blob/main/lua/smear_cursor/config.lua

    -- Smear cursor when switching buffers or windows.
    smear_between_buffers = true,

    -- Smear cursor when moving within line or to neighbor lines.
    -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
    smear_between_neighbor_lines = true,

    -- Draw the smear in buffer space instead of screen space when scrolling
    scroll_buffer_space = true,

    -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
    -- Smears will blend better on all backgrounds.
    legacy_computing_symbols_support = false,

    -- Smear cursor in insert mode.
    -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
    smear_insert_mode = true,

    --cursor_color = '#d3cdc3',

    -- fire hazard
    cursor_color = "#23a17e",
    stiffness = 0.5,
    trailing_stiffness = 0.3,
    trailing_exponent = 1,
    never_draw_over_target = true,
    distance_stop_animating = 0.5,        -- 0.1      > 0

    --hide_target_hack = true,
    gamma = 0.75,
  },
}
