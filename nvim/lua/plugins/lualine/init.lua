local function init()
  local function tree_sitter_status_line()
    --return [[hello world]]
    return vim.api.nvim_call_function("nvim_treesitter#statusline", {90})
  end

  require('lualine').setup({
    options = {
      icons_enabled = true,
      theme = 'gruvbox_dark'
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff'},
      lualine_c = {'filename'},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location', 'selectioncount'}
    },
  })
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    init()
  end,
}
