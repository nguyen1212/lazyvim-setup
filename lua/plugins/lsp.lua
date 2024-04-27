return {
  -- servers
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    keys = {},
    opts = {
      servers = {
        -- csharp_ls = {},
        vuels = {},
        gopls = {
          keys = {
            -- Workaround for the lack of a DAP strategy in neotest-go: https://github.com/nvim-neotest/neotest-go/issues/12
            { "<leader>td", "<cmd>lua require('dap-go').debug_test()<CR>", desc = "Debug Nearest (Go)" },
          },
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
                fieldalignment = false,
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
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              semanticTokens = true,
              analysisProgressReporting = true, -- false: stop indexing for new files (when written)
            },
          },
        },
      },
    },
  },
}
