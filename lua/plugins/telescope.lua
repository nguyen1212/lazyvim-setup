return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader><leader>", false },
    },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    enabled = vim.fn.executable("make") == 1,
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },

  -- yanky
  {
    "gbprod/yanky.nvim",
    config = function()
      local utils = require("yanky.utils")
      local mapping = require("yanky.telescope.mapping")

      require("yanky").setup({
        picker = {
          telescope = {
            mappings = {
              default = mapping.put("p"),
              i = {
                ["<c-g>"] = mapping.put("p"),
                ["<c-k>"] = mapping.put("P"),
                ["<c-x>"] = mapping.delete(),
                ["<c-r>"] = mapping.set_register(utils.get_default_register()),
              },
              n = {
                p = mapping.put("p"),
                P = mapping.put("P"),
                d = mapping.delete(),
                r = mapping.set_register(utils.get_default_register()),
              },
            },
          },
        },
      })
    end,
  },
  { "nvim-telescope/telescope-live-grep-args.nvim" },
}
