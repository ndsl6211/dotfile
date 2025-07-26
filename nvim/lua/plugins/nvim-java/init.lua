local function init()
  require("java").setup({
    java_debug_adapter = {
      enable = true,
      version = "0.58.2"  -- Use the working version instead of default 0.58.1
    }
  })
end

return {
  "nvim-java/nvim-java",
  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  enabled = false,
  config = function()
    init()
  end,
  ft = { "java", "gradle", "kotlin" },
}
