local function init_nvim_lsp()
  -- Enable the following language servers only if Neovim version >= 0.11
  if vim.fn.has('nvim-0.11') == 1 then
    -- python
    vim.lsp.enable({ "pyright", "ruff" })

    -- rust
    vim.lsp.enable("rust_analyzer")

    -- typescript
    vim.lsp.enable("ts_ls")

    -- clang
    vim.lsp.enable("clangd")

    -- golang
    vim.lsp.enable("gopls")

    -- vim
    vim.lsp.enable("vimls")

    -- bash
    vim.lsp.enable("bashls")

    -- lua
    vim.lsp.enable("lua_ls")

    -- java
    vim.lsp.enable("jdtls")
    vim.lsp.enable("kotlin_language_server")

    -- dart
    vim.lsp.enable("dartls")

    -- html
    vim.lsp.enable("html")

    -- css
    vim.lsp.enable("cssls")

    -- json
    vim.lsp.enable("jsonls")

    -- yaml
    vim.lsp.enable("yamlls")

    -- hcl
    vim.lsp.enable("terraformls")

    -- prisma
    vim.lsp.enable("prismals")

    -- protobuf
    vim.lsp.enable("buf_ls")
  else
    vim.notify("Neovim version >= 0.11 is required for LSP support", vim.log.levels.WARN)
  end


  -- Global mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
  --vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
  --vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
  --vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

  -- Use LspAttach autocommand to only map the following keys
  -- after the language server attaches to the current buffer
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local opts = { buffer = ev.buf }
      vim.keymap.set('n', '<C-h>', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, opts)

      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', 'gR', vim.lsp.buf.references, opts)

      --vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
      --vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
      --vim.keymap.set('n', '<space>wl', function()
      --print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      --end, opts)
      --vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
      --vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)

      -- rename variable
      vim.keymap.set('n', '<A-r>', vim.lsp.buf.rename, opts)

      -- format code + organize imports
      vim.keymap.set('n', '<A-f>', function()
        vim.lsp.buf.format({ async = false })
        vim.lsp.buf.code_action({
          context = {
            only = { "source.organizeImports" },
            diagnostics = {},
          },
          apply = true,
        })
      end, opts)

      --vim.api.nvim_command('autocmd BufWritePre <buffer> lua vim.lsp.buf.format { async = true }')
    end,
  })
end

local function init_nvim_cmp()
  local cmp = require('cmp')
  local kind_icons = {
    Text = "",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "󰇽",
    Variable = "󰂡",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "󰅲",
  }
  --local cmp_kinds = {
  --Text = '  ',
  --Method = '  ',
  --Function = '  ',
  --Constructor = '  ',
  --Field = '  ',
  --Variable = '  ',
  --Class = '  ',
  --Interface = '  ',
  --Module = '  ',
  --Property = '  ',
  --Unit = '  ',
  --Value = '  ',
  --Enum = '  ',
  --Keyword = '  ',
  --Snippet = '  ',
  --Color = '  ',
  --File = '  ',
  --Reference = '  ',
  --Folder = '  ',
  --EnumMember = '  ',
  --Constant = '  ',
  --Struct = '  ',
  --Event = '  ',
  --Operator = '  ',
  --TypeParameter = '  ',
  --}
  cmp.setup({
    window = {
      completion = {
        border = 'rounded',
        scrollbar = '║',
      },
      documentation = {
        border = 'rounded',
        scrollbar = '',
        -- border = nil,
        -- scrollbar = ''
      },
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-k>'] = cmp.mapping.select_prev_item(),
      ['<C-j>'] = cmp.mapping.select_next_item(),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'nvim_lsp_signature_help' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    }),
    formatting = {
      fields = { "icon", "abbr", "menu" }, -- "kind", "icon", "abbr", "menu"
      format = function(entry, vim_item)
        local entrySourceName = ({
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          luasnip = "[LuaSnip]",
          nvim_lua = "[Lua]",
          latex_symbols = "[LaTeX]",
        })[entry.source.name] or ""

        local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
        --local strings = vim.split(kind.kind, "%s", { trimempty = true })
        local type_name = kind.kind
        --kind.menu = "    (" .. (strings[2] or "") .. ")"
        kind.menu = "(" .. type_name .. ")" .. entrySourceName

        return kind
      end
    },
  })
end

local function init_nvim_cmp_cmdline()
  local cmp = require('cmp')
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      {
        name = 'cmdline',
        option = {
          ignore_cmds = { 'Man', '!' }
        }
      }
    })
  })
end

return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/nvim-cmp",
    "onsails/lspkind.nvim",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp-signature-help"
    --"ray-x/lsp_signature.nvim"
    -- "saadparwaiz1/cmp_luasnip",
    -- "L3MON4D3/LuaSnip",
    -- "rafamadriz/friendly-snippets",
  },
  config = function()
    init_nvim_lsp()
    init_nvim_cmp()
    init_nvim_cmp_cmdline()
  end,
}
