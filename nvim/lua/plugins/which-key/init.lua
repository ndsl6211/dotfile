local function init()
  require("which-key").setup({
    preset = "modern",

    win = {
      -- "none", "single", "double", "rounded", "solid", "shadow"
      border = "rounded",

      -- 3. position settings：
      -- row = math.huge -> bottom
      -- col = 1 -> left
      row = math.huge,
      col = math.huge,

      -- width settings
      width = 0.3,

      padding = { 1, 2 },
      title = true,
      title_pos = "center",
    },
  })
end

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  config = function()
    init()
  end,
  enabled = true,
}
