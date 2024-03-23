return {
  {
    "mfussenegger/nvim-lint",
    -- optional = true,
    opts = {
      linters = {
        markdownlint = {
          args = { "-q" },
        },
      },
    },
  },
}
