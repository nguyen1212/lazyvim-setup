return {
  -- language servers
  {
    "neovim/nvim-lspconfig",
    keys = {},
    opts = {
      diagnostics = {
        underline = true,
        virtual_text = false,
        float = false,
      },
      servers = {
        -- csharp_ls = {},
        marksman = {},
        vuels = {},
        gopls = {
          -- cmd = {
          --   "gopls",
          --   "-rpc.trace",
          --   "serve",
          --   "--debug=localhost:6060",
          -- },
          keys = {
            -- Workaround for the lack of a DAP strategy in neotest-go: https://github.com/nvim-neotest/neotest-go/issues/12
            { "<leader>td", false },
            {
              "<leader>co",
              LazyVim.lsp.action["source.organizeImports"],
              desc = "Organize Imports",
            },
          },
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
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = {
        "<C-k>",
        false,
        mode = "i",
        desc = "Signature help",
      }
    end,
  },
}
