local function init()
  -- set the highlight for the cursorline to "underline" without bg
  -- Note: this lua function will automatically determine cterm and gui through the variable
  -- "termguicolors". You can check the value of "termguicolors" by running ":echo &termguicolors"
  vim.api.nvim_set_hl(0, "CursorLine", {
    underline = true,
    bg = "NONE"
  })

  vim.api.nvim_set_hl(0, "CursorColumn", {
    underline = false,
    bg = "#4a4a4a"
  })
end

init()

return {
  { 'savq/melange-nvim' },
  { 'ellisonleao/gruvbox.nvim' },
  { 'catppuccin/nvim', name = 'catppuccin' },
  { 'rebelot/kanagawa.nvim' },
  { 'rose-pine/neovim', name = 'rose-pine' },
  { 'dracula/vim' },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  { 'EdenEast/nightfox.nvim' },
  { 'lunarvim/darkplus.nvim' },
  { 'lunarvim/onedarker.nvim' },
  { 'lunarvim/onedark.nvim' },
  { 'lunarvim/templeos.nvim' },
  { 'lunarvim/everforest.nvim' },
  { 'lunarvim/sonokai.nvim' },
  { 'lunarvim/synthwave84.nvim' },
  { 'lunarvim/oxocarbon.nvim' },
  { 'lunarvim/kanagawa.nvim' },
  { 'lunarvim/ayu-vim' },
}
