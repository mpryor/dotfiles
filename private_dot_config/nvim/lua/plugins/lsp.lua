-- LSP Plugins
return {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} }, -- in charge of managing lsp servers, linters & formatters
      'mason-org/mason-lspconfig.nvim', -- bridges mason with lspconfig, lspconfig is used to configure the lsp servers
      'WhoIsSethDaniel/mason-tool-installer.nvim', -- auto install LSP servers, linters, formatters
      'mfussenegger/nvim-jdtls',
      { 'j-hui/fidget.nvim', opts = {} }, -- status updates for LSP
      'saghen/blink.cmp', -- completion
    },
    config = function()
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = {
          severity = vim.diagnostic.severity.ERROR,
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
           },
        },
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local servers = {
        ruff = {}, -- linter for python, also provides some formatting
        basedpyright = {}, -- better fork of pyright, includes type hints, import completion, etc
        gopls = {}, -- Go language server
        clangd ={}, -- C/C++ language server
        bashls = {}, -- Bash language server
        jdtls = {},
        lua_ls = { -- Lua language server
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace', -- don't add parentheses when completing functions
              },
            },
          },
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
        'shfmt', -- Used to format bash 
        'bash-debug-adapter' -- Used to debug bash
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
