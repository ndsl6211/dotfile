local function init()
  vim.o.foldmethod = "expr"
  --vim.o.foldexpr = "nvim_treesitter#foldexpr()"
  vim.o.foldenable = false

  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      "c", "cpp",
      "vim", "lua",
      "json", "yaml",
      "java", "kotlin",
      "python",
      "rust",
      "typescript", "javascript", "prisma",
      "go", "jsdoc", "regex",
      "html", "css", "scss", "vue"
    },
    sync_install = false,
    auto_install = false,
    highlight = {
      enable = true,
    },
    indent = {
      enable = false
    }
  })
end

return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function ()
    init()
  end,
}
