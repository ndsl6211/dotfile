local function init()
  require("nvim-surround").setup({})
end

return {
  "kylechui/nvim-surround",
  version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
    init()
  end,
}
