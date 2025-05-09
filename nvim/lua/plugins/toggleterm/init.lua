local function init()
  require("toggleterm").setup({
    open_mapping = [[<c-\>]],
    winbar = {
      enabled = false,
      name_formatter = function(term) --  term: Terminal
        return term.name
      end
    },
    size = function(term)
      if term.direction == "horizontal" then
        return vim.o.lines * 0.4
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end
  })
end

return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    init()
  end,
}
