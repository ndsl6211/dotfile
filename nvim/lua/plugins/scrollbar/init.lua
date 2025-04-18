local function init()
  require("scrollbar").setup()
end

return {
  'petertriho/nvim-scrollbar',
  config = function()
    init()
  end,
}
