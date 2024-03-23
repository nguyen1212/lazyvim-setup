return {
  -- servers
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    keys = {
      {
        "<S-k>",
        function()
          require("cmp.entry").get_documentation()
        end,
        desc = "LSP documentation",
      },
      {
        "<C-k>",
        function()
          vim.lsp.buf.signature_help()
        end,
        mode = { "i" },
        desc = "LSP signature help",
      },
    },
    opts = {
      servers = {
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
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
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
              analysisProgressReporting = false, -- stop indexing for new files (when written)
            },
          },
        },
      },
    },
  },
}
