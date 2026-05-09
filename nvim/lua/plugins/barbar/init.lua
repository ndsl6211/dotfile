local function init()
  local map = vim.api.nvim_set_keymap

  -- Move to previous/next
  map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true, desc = "Buffer previous" })
  map('n', '<A-.>', '<Cmd>BufferNext<CR>', { noremap = true, silent = true, desc = "Buffer next" })
  -- Re-order to previous/next
  map('n', '<A-[>', '<Cmd>BufferMovePrevious<CR>', { noremap = true, silent = true, desc = "Buffer move left" })
  map('n', '<A-]>', '<Cmd>BufferMoveNext<CR>', { noremap = true, silent = true, desc = "Buffer move right" })
  -- Goto buffer in position...
  map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', { noremap = true, silent = true, desc = "Go to buffer 1" })
  map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', { noremap = true, silent = true, desc = "Go to buffer 2" })
  map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', { noremap = true, silent = true, desc = "Go to buffer 3" })
  map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', { noremap = true, silent = true, desc = "Go to buffer 4" })
  map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', { noremap = true, silent = true, desc = "Go to buffer 5" })
  map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', { noremap = true, silent = true, desc = "Go to buffer 6" })
  map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', { noremap = true, silent = true, desc = "Go to buffer 7" })
  map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', { noremap = true, silent = true, desc = "Go to buffer 8" })
  map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', { noremap = true, silent = true, desc = "Go to buffer 9" })
  map('n', '<A-0>', '<Cmd>BufferLast<CR>', { noremap = true, silent = true, desc = "Go to last buffer" })
  -- Pin/unpin buffer
  map('n', '<A-p>', '<Cmd>BufferPin<CR>', { noremap = true, silent = true, desc = "Pin/unpin buffer" })
  -- Close buffer
  map('n', '<A-c>', '<Cmd>BufferClose<CR>', { noremap = true, silent = true, desc = "Close buffer" })
  -- Wipeout buffer
  --                 :BufferWipeout
  -- Close commands
  --                 :BufferCloseAllButCurrent
  --                 :BufferCloseAllButPinned
  --                 :BufferCloseAllButCurrentOrPinned
  --                 :BufferCloseBuffersLeft
  --                 :BufferCloseBuffersRight
  -- Magic buffer-picking mode
  map('n', '<C-p>', '<Cmd>BufferPick<CR>', { noremap = true, silent = true, desc = "Pick buffer" })
  -- Sort automatically by...
  --map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
  --map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
  --map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
  --map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

  -- Other:
  -- :BarbarEnable - enables barbar (enabled by default)
  -- :BarbarDisable - very bad command, should never be used
end

return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  -- init = function() vim.g.barbar_auto_setup = false end,
  config = function()
    init()
  end,
  version = '1.9.1', -- optional: only update when a new 1.x version is released
}
