--vim.g.indent_blankline_char = '┆'
--vim.g.indent_blankline_use_treesitter = true

--local highlight = {
    --"RainbowRed",
    --"RainbowYellow",
    --"RainbowBlue",
    --"RainbowOrange",
    --"RainbowGreen",
    --"RainbowViolet",
    --"RainbowCyan",
--}

--local hooks = require "ibl.hooks"
---- create the highlight groups in the highlight setup hook, so they are reset
---- every time the colorscheme changes
--hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    --vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    --vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    --vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    --vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    --vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    --vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    --vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
--end)

--local highlight = {
    --"CursorColumn",
    --"Whitespace",
--}
--require("ibl").setup {
    --indent = { highlight = highlight, char = "" },
    --whitespace = {
        --highlight = highlight,
        --remove_blankline_trail = false,
    --},
    --scope = { enabled = false },
--}

local function init ()
  require('ibl').setup({
    indent = {
      char = '▍',
    },
    scope = {
      enabled = true,
      char = '→'
    },
  })

  vim.keymap.set('n', '<leader>iblt', '<Esc>:IBLToggle<CR>', {
    noremap = true,
    silent = true
  })
end

return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
  opts = {},
  config = function()
    init()
  end,
}
