return {
  -- language servers
  {
    "neovim/nvim-lspconfig",
    keys = {},
    opts = {
      diagnostics = {
        underline = true,
      },
      servers = {
        -- csharp_ls = {},
        vuels = {},
        gopls = {
          cmd = {
            "gopls",
            "-rpc.trace",
            "serve",
            "--debug=localhost:6060",
          },
          -- keys = {
          --   -- Workaround for the lack of a DAP strategy in neotest-go: https://github.com/nvim-neotest/neotest-go/issues/12
          --   { "<leader>td", "<cmd>lua require('dap-go').debug_test()<CR>", desc = "Debug Nearest (Go)" },
          -- },
          -- flags = {
          --   debounce_text_changes = 500, -- Increase debounce time
          -- },
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = false,
                compositeLiteralTypes = false,
                constantValues = true,
                functionTypeParameters = false,
                parameterNames = false,
                rangeVariableTypes = false,
              },
              analyses = {
                assign = false,
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                unreachable = true,
                useany = true,
                shadow = true,
              },
              usePlaceholders = false,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules", "-**/tests" },
              semanticTokens = true,
              analysisProgressReporting = true, -- false: stop indexing for new files (when written)
            },
          },
        },
      },
    },
    -- setup = {
    --   gopls = function(_, opts)
    --     -- workaround for gopls not supporting semanticTokensProvider
    --     -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
    --     LazyVim.lsp.on_attach(function(client, bufnr)
    --       if client.name == "gopls" then
    --         -- Enable completion triggered by <c-x><c-o>
    --         -- vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
    --         if not client.server_capabilities.semanticTokensProvider then
    --           local semantic = client.config.capabilities.textDocument.semanticTokens
    --           client.server_capabilities.semanticTokensProvider = {
    --             full = true,
    --             legend = {
    --               tokenTypes = semantic.tokenTypes,
    --               tokenModifiers = semantic.tokenModifiers,
    --             },
    --             range = true,
    --           }
    --         end
    --       end
    --     end)
    --     -- end workaround
    --   end,
    -- },
  },
}
