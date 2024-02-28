return {
  {
    -- go extension
    {
      "fatih/vim-go",
      dependencies = "fatih/gomodifytags",
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
        { "<leader>aa", "<cmd>GoAlternate!<CR>", desc = "Open/Create go test file", ft = "go" },
        { "<leader>t", "<cmd>GoTestFunc<CR>", desc = "Go test function", ft = "go" },
        { "<leader><S-t>", "<cmd>GoTestFile<CR>", desc = "Go test file", ft = "go" },
        { "<leader>ae", "<plug>(go-alternate-edit)", desc = "Open go test file", ft = "go" },
        { "<leader>av", "<plug>(go-alternate-vertical)", desc = "Vertical split go test file", ft = "go" },
        { "<leader>ds", "<plug>(go-def-split)", desc = "Horizontal split go definition", ft = "go" },
        { "<leader>dv", "<plug>(go-def-vertical)", desc = "Vertical split go definition", ft = "go" },
        { "<leader>gfs", "<cmd>GoFillStruct<CR>", desc = "Fill go struct", ft = "go" },
        { "<leader>gat", "<cmd>GoAddTags<CR>", desc = "Add go tags", ft = "go" },
      },
      config = function()
        vim.cmd([[do FileType]])
      end,
    },
    "AndrewRadev/splitjoin.vim",
    "fatih/gomodifytags",
    {
      "leoluz/nvim-dap-go",
      dependencies = { "mfussenegger/nvim-dap" },
      config = true,
    },
    {
      "williamboman/mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, {
          "goimports",
          "gofumpt",
          "gopls",
          "gomodifytags",
          "impl",
          "delve",
        })
      end,
    },
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
