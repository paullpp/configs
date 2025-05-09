vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('user_lsp_attach', {clear = true}),
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
    vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
  end,
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'ts_ls', 'eslint', 'bashls', 'cssls', 'docker_compose_language_service', 'dockerls', 'html', 'lua_ls', 'pylsp', 'gopls', 'sqls', 'terraformls', 'tflint'},
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({
        capabilities = lsp_capabilities,
      })
    end,
    lua_ls = function()
      require('lspconfig').lua_ls.setup({
        capabilities = lsp_capabilities,
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT'
            },
            diagnostics = {
              globals = {'vim'},
            },
            workspace = {
              library = {
                vim.env.VIMRUNTIME,
              }
            }
          }
        }
      })
    end,
    pylsp = function()
        require('lspconfig').pylsp.setup {
          settings = {
            pylsp = {
              plugins = {
                -- formatter options
                black = { enabled = false },
                ruff = {
                  enabled = true,
                },
                pycodestyle = { enabled = true, maxLineLength = 150 },
                pylsp_mypy = {
                  enabled = true,
                  report_progress = true,
                  live_mode = true,
                  exclude = { "venv", "\\.venv", "migrations", "__pycache__", "\\.git", "\\.tox", "\\.github" },
                  overrides = vim.env.VIRTUAL_ENV and { true, "--python-executable", vim.env.VIRTUAL_ENV .. "/bin/python" }
                },
              },
            },
          },
          flags = {
            debounce_text_changes = 200,
          },
          capabilities = lsp_capabilities,
        }
    end,
    ruff = function()
      require('lspconfig').ruff.setup {
        init_options = {
          settings = {
            lineLength = 150
          }
        },
        capabilities = lsp_capabilities
      }
    end,
    gopls = function()
      require('lspconfig').gopls.setup({
        capabilities = lsp_capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
            usePlaceholders = true,
            completeUnimported = true,
          },
        },
      })
    end,
    ts_ls = function()
      require('lspconfig').ts_ls.setup({
        capabilities = lsp_capabilities
      })
    end,
    terraformls = function()
      require('lspconfig').terraformls.setup({
        capabilities = lsp_capabilities
      })
    end,
  }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  sources = cmp.config.sources({
    {name = 'nvim_lsp'},
    {name = 'luasnip'},
  }, {
    {name = 'buffer'},
  }),
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})
