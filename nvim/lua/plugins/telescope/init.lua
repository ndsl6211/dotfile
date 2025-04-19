local function init()
  local builtin = require('telescope.builtin')

  vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
  vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
  vim.keymap.set('n', '<leader>ft', builtin.treesitter, {})
  vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
  vim.keymap.set('n', '<leader>fm', builtin.keymaps, {})

  vim.keymap.set(
    'n',
    'gd',
    function ()
      builtin.lsp_definitions({
        jump_type = 'vsplit',
      })
    end,
    {}
  )
  vim.keymap.set(
    'n',
    'gD',
    function ()
      builtin.lsp_type_definitions({
        jump_type = 'vsplit',
      })
    end,
    {}
  )
  vim.keymap.set(
    'n',
    'gi',
    function ()
      builtin.lsp_implementations({
        jump_type = 'vsplit',
      })
    end,
    {}
  )
  vim.keymap.set(
    'n',
    'gr',
    function ()
      builtin.lsp_references({
        jump_type = 'vsplit',
      })
    end,
    {}
  )
end

return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      init()
    end,
  },
  -- {
  --   'nvim-telescope/telescope-fzf-native.nvim',
  --   build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
  -- },
}
