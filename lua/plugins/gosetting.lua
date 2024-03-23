return {
  {
    -- go extension
    {
      "fatih/vim-go",
      dependencies = "fatih/gomodifytags",
      -- event = "BufEnter",
      ft = "go",
      cmd = {
        "GoAlternate",
        "GoCoverage",
        "GoCoverageToggle",
        "GoTestFunc",
        "GoTestFile",
        "GoFillStruct",
        "GoAddTags",
        "GoModReload",
      },
      keys = {
        { "<leader>aa", "<cmd>GoAlternate!<CR>", desc = "Open/Create go test file" },
        {
          "<leader>t",
          function()
            vim.cmd([[GoTestFunc]])
          end,
          desc = "Go test function",
          ft = "go",
        },
        { "<leader><S-t>", "<cmd>GoTestFile<CR>", desc = "Go test file" },
        { "<leader>ae", "<plug>(go-alternate-edit)", desc = "Open go test file" },
        { "<leader>av", "<plug>(go-alternate-vertical)", desc = "Vertical split go test file" },
        { "<leader>ds", "<plug>(go-def-split)", desc = "Horizontal split go definition" },
        { "<leader>dv", "<plug>(go-def-vertical)", desc = "Vertical split go definition" },
        { "<leader>gfs", "<cmd>GoFillStruct<CR>", desc = "Fill go struct" },
        { "<leader>gat", "<cmd>GoAddTags<CR>", desc = "Add go tags" },
      },
      config = function()
        vim.cmd([[
          let g:go_term_enabled = 1
          let g:go_term_reuse = 1
          let g:go_term_close_on_exit = 0
        ]])
      end,
    },

    -- formatters
    {
      "stevearc/conform.nvim",
      optional = true,
      opts = {
        formatters_by_ft = {
          go = { "goimports", "gofumpt" },
        },
      },
    },
  },
}
