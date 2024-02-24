return {
  {
    "folke/flash.nvim",
    enabled = false,
  },
  {
    -- terminal
    "akinsho/toggleterm.nvim",
    config = true,
  },

  -- code comment
  { "tpope/vim-commentary" },

  -- which-keys
  {
    "folke/which-key.nvim",
    enabled = false,
  },

  -- noice
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = false,
      },
      routes = {
        {
          filter = {
            warning = true,
          },
          opts = {
            skip = true,
          },
        },
      },
    },
    keys = {
      {
        "<c-d>",
        function()
          if not require("noice.lsp").scroll(4) then
            return "<c-f>"
          end
        end,
        silent = true,
        expr = true,
        desc = "Scroll forward",
        mode = { "i", "n", "s" },
      },
      {
        "<c-u>",
        function()
          if not require("noice.lsp").scroll(-4) then
            return "<c-b>"
          end
        end,
        silent = true,
        expr = true,
        desc = "Scroll backward",
        mode = { "i", "n", "s" },
      },
    },
  },
}
