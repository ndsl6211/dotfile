local languages = {
  "c", "cpp",
  "vim", "lua",
  "json", "yaml",
  "java", "kotlin",
  "python",
  "rust",
  "typescript", "javascript", "prisma",
  "go", "jsdoc", "regex",
  "html", "css", "scss", "vue"
}

local is_012 = vim.fn.has('nvim-0.12') == 1

local function init()
  vim.o.foldenable = false

  if is_012 then
    vim.o.foldmethod = "expr"
    vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

    require('nvim-treesitter').install(languages)

    vim.api.nvim_create_autocmd('FileType', {
      pattern = languages,
      callback = function() vim.treesitter.start() end,
    })
  else
    vim.o.foldmethod = "expr"

    require('nvim-treesitter.configs').setup({
      ensure_installed = languages,
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
end

return {
  'nvim-treesitter/nvim-treesitter',
  branch = is_012 and 'main' or 'master',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    init()
  end,
}
