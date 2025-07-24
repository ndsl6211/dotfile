local function init()
  require("java").setup({})

  local lspconfig = require("lspconfig")
  lspconfig.jdtls.setup({
    settings = {
      java = {
        configuration = {
          runtimes = {
            {
              name = "OpenJDK 21",
              path = "/home/mashu/.sdkman/candidates/java/21.0.2-open",
              default = true,
            }
          }
        }
      }
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
  enabled = true,
  config = function ()
    init()
  end,
  ft = { "java", "gradle", "kotlin" },
}
