return {
  'ndsl6211/nvim-gemini-cli',
  build = 'cd server && go build -o ../bin/gemini-mcp-server',
  config = function()
    require('gemini-cli').setup({
      -- Auto-start server when Neovim starts
      auto_start = true,

      -- Log level: 'debug', 'info', 'warn', 'error'
      log_level = 'info',

      -- Debounce time for context updates (ms)
      context_debounce_ms = 50,

      -- Maximum number of open files to track
      max_open_files = 10,

      -- Allow :w in diff window to accept changes
      -- If false, you must accept via CLI prompt
      allow_w_to_accept = true,

      -- Automatically setup default keymaps (<leader>gc, <leader>gs)
      setup_keymaps = true,

      -- Focus Gemini terminal when opened via command/keymap (default: true)
      focus_on_open = true,

      -- Focus Gemini terminal when automatically opened by GeminiSend (default: false)
      focus_on_send = false,
    })
  end,
}
