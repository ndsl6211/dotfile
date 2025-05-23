local function init()
  local registers = require("registers")
  registers.setup({
    -- Show these registers in the order of the string
    show = "*+\"-/_=#%.0123456789abcdefghijklmnopqrstuvwxyz:",
    -- Show a line at the bottom with registers that aren't filled
    show_empty = true,
    -- Expose the :Registers user command
    register_user_command = true,
    -- Always transfer all selected registers to the system clipboard
    system_clipboard = true,
    -- Don't show whitespace at the begin and end of the register's content
    trim_whitespace = true,
    -- Don't show registers which are exclusively filled with whitespace
    hide_only_whitespace = true,
    -- Show a character next to the register name indicating how the register will be applied
    show_register_types = true,
    bind_keys = {
      -- Show the window when pressing " in normal mode, applying the selected register as part of a motion, which is the default behavior of Neovim
      normal    = registers.show_window({ mode = "motion" }),
      -- Show the window when pressing " in visual mode, applying the selected register as part of a motion, which is the default behavior of Neovim
      visual    = registers.show_window({ mode = "motion" }),
      -- Show the window when pressing <C-R> in insert mode, inserting the selected register, which is the default behavior of Neovim
      insert    = registers.show_window({ mode = "insert" }),

      -- When pressing the key of a register, apply it with a very small delay, which will also highlight the selected register
      registers = registers.apply_register({ delay = 0.1 }),
      -- Immediately apply the selected register line when pressing the return key
      ["<CR>"]  = registers.apply_register(),
      -- Close the registers window when pressing the Esc key
      ["<Esc>"] = registers.close_window(),

      -- Move the cursor in the registers window down when pressing <C-n>
      ["<C-n>"] = registers.move_cursor_down(),
      -- Move the cursor in the registers window up when pressing <C-p>
      ["<C-p>"] = registers.move_cursor_up(),
      -- Move the cursor in the registers window down when pressing <C-j>
      ["<C-j>"] = registers.move_cursor_down(),
      -- Move the cursor in the registers window up when pressing <C-k>
      ["<C-k>"] = registers.move_cursor_up(),
      -- Clear the register of the highlighted line when pressing <DeL>
      ["<Del>"] = registers.clear_highlighted_register(),
      -- Clear the register of the highlighted line when pressing <BS>
      ["<BS>"]  = registers.clear_highlighted_register(),
    },
    events = {
      -- When a register line is highlighted, show a preview in the main buffer with how the register will be applied, but only if the register will be inserted or pasted
      on_register_highlighted = registers.preview_highlighted_register({ if_mode = { "insert", "paste" } }),
    },
    symbols = {
      -- Show a special character for line breaks
      newline = "⏎",
      -- Show space characters without changes
      space = " ",
      -- Show a special character for tabs
      tab = "·",
      -- The character to show when a register will be applied in a char-wise fashion
      register_type_charwise = "ᶜ",
      -- The character to show when a register will be applied in a line-wise fashion
      register_type_linewise = "ˡ",
      -- The character to show when a register will be applied in a block-wise fashion
      register_type_blockwise = "ᵇ",
    },
    window = {
      -- The window can't be wider than 100 characters
      max_width = 100,
      -- Show a small highlight in the sign column for the line the cursor is on
      highlight_cursorline = true,
      -- Don't draw a border around the registers window
      border = "rounded",
      -- Apply a tiny bit of transparency to the the window, letting some characters behind it bleed through
      transparency = 10,
    },
    -- Highlight the sign registers as regular Neovim highlights
    sign_highlights = {
      cursorlinesign = "CursorLine",
      signcolumn = "NormalFloat",
      cursorline = "Visual",
      selection = "Constant",
      default = "Function",
      unnamed = "Statement",
      read_only = "Type",
      expression = "Exception",
      black_hole = "Error",
      alternate_buffer = "Operator",
      last_search = "Tag",
      delete = "Special",
      yank = "Delimiter",
      history = "Number",
      named = "Todo",
    },
  })
end

return {
  "tversteeg/registers.nvim",
  cmd = "Registers",
  config = function ()
    init()
  end,
  keys = {
    { "\"",    mode = { "n", "v" } },
    { "<C-R>", mode = "i" },
  },
  name = "registers",
}
