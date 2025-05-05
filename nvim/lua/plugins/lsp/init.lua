local function init_nvim_lsp()
  local lspconfig = require('lspconfig')

  --Enable (broadcasting) snippet capability for completion
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true


  -- python
  lspconfig.pyright.setup({
    settings = {
      pyright = {
        -- Using Ruff's import organizer
        disableOrganizeImports = true,
      },
      python = {
        analysis = {
          autoImportCompletions = true,
          typeCheckingMode = "off",
          -- Ignore all files for analysis to exclusively use Ruff for linting
          ignore = { '*' },
        }
      }
    }
  })

  -- rust
  lspconfig.rust_analyzer.setup({})

  -- ruff
  lspconfig.ruff.setup({
    init_options = {
      settings = {
        lineLength = 100
      }
    }
  })

  lspconfig.ruff.setup({
    init_options = {
      settings = {
        args = { "--line-length=100" }
      }
    }
  })

  -- typescript
  lspconfig.ts_ls.setup({})

  -- golang
  lspconfig.gopls.setup({})

  -- vim
  lspconfig.vimls.setup({})

  -- bash
  lspconfig.bashls.setup({})

  -- lua
  lspconfig.lua_ls.setup({
    on_init = function(client)
      local path = client.workspace_folders[1].name
      if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
        return
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          -- Tell the language server which version of Lua you're using
          -- (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT'
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME
            -- Depending on the usage, you might want to add additional paths here.
            -- "${3rd}/luv/library"
            -- "${3rd}/busted/library",
          }
          -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
          -- library = vim.api.nvim_get_runtime_file("", true)
        }
      })
    end,
    settings = {
      Lua = {}
    },
    capabilities = capabilities,
  })

  -- html
  lspconfig.html.setup({
    capabilities = capabilities,
  })

  -- css
  lspconfig.cssls.setup({
    capabilities = capabilities,
  })

  -- json
  lspconfig.jsonls.setup({
    capabilities = capabilities,
  })

  -- yaml
  lspconfig.yamlls.setup {
    settings = {
      yaml = {
        schemas = {
          ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        },
        schemaStore = {
          enable = true,
          url = "https://www.schemastore.org/api/json/catalog.json",
        }
      },
    }
  }

  -- hcl
  lspconfig.terraformls.setup({})

  -- prisma
  lspconfig.prismals.setup({})

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

      vim.keymap.set('n', '<A-r>', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', '<A-f>', function()
        vim.lsp.buf.format({ async = true })
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
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        -- Kind icons
        local entrySourceName = ({
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          luasnip = "[LuaSnip]",
          nvim_lua = "[Lua]",
          latex_symbols = "[LaTeX]",
        })[entry.source.name] or ""

        local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
        local strings = vim.split(kind.kind, "%s", { trimempty = true })
        kind.kind = (strings[1] or "")
        --kind.menu = "    (" .. (strings[2] or "") .. ")"
        kind.menu = "(" .. (strings[2] or "") .. ")" .. entrySourceName

        return kind
      end
    },
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
  end,
}
