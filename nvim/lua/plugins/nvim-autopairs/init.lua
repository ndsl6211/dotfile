local function init ()
  require('nvim-autopairs').setup({})
end

return {
  'windwp/nvim-autopairs',
  event = "InsertEnter",
  config = function ()
    init()
  end,
}
