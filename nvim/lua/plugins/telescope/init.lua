local function init()
  local builtin = require('telescope.builtin')

  vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Find commands' })
  vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
  vim.keymap.set('n', '<leader>fof', builtin.oldfiles, { desc = 'Find recently opened files' })
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep text' })
  vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find help tags' })
  vim.keymap.set('n', '<leader>ft', builtin.treesitter, { desc = 'Find treesitter symbols' })
  vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = 'Find LSP references' })
  vim.keymap.set('n', '<leader>fm', builtin.keymaps, { desc = 'Find keymaps' })
  vim.keymap.set('n', '<leader>fp', builtin.planets, { desc = 'Find planets' })

  vim.keymap.set('n', '<leader>gd',
    function ()
      --builtin.lsp_definitions({ jump_type = 'vsplit' })
      builtin.lsp_definitions({ noremap = true, silent = true })
    end,
    { desc = 'Go to definition' }
  )
  vim.keymap.set('n', '<leader>gD',
    function ()
      builtin.lsp_type_definitions({ jump_type = 'vsplit' })
    end,
    { desc = 'Go to type definition' }
  )
  vim.keymap.set('n', '<leader>gi',
    function ()
      --builtin.lsp_implementations({ jump_type = 'vsplit' })
      builtin.lsp_implementations({ noremap = true, silent = true })
    end,
    { desc = 'Go to implementation' }
  )
  vim.keymap.set('n', 'gr',
    function ()
      --builtin.lsp_references({ jump_type = 'vsplit' })
      builtin.lsp_references({ noremap = true, silent = true })
    end,
    { desc = 'Go to references' }
  )
end

return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    priority = 1000,
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
