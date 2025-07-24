local function init_mason_lspconfig()
  require("mason-lspconfig").setup({
    ensure_installed = {
      "bashls",
      "clangd",
      "cssls",
      "dockerls",
      "gopls",
      "html",
      "jsonls",
      "jdtls",
      "lua_ls",
      "pyright",
      "prismals",
      "rust_analyzer",
      "ts_ls",
      "terraformls",
      "yamlls",
    },
    automatic_installation = true,
  })
end

return {
  {
    "mason-org/mason.nvim",
    version = "^1.0.0",
    enabled = true,
    config = function ()
      require("mason").setup({})
    end,
    priority = 1000,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    version = "^1.0.0",
    enabled = true,
    config = function()
      init_mason_lspconfig()
    end
  }
}
