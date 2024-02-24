return {
  {
    -- go extension
    {
      "fatih/vim-go",
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
