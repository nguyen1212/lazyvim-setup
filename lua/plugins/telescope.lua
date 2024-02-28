return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader><leader>", false },
      { "<leader>ff", "<cmd>Telescope find_files hidden=true<CR>", desc = "Find Files (including hidden files)" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find Buffers" },
      { "gr", "<cmd>Telescope lsp_references<CR>", desc = "Goto References" },
      { "gy", "<cmd>Telescope lsp_type_definition<CR>", desc = "Goto Type Definition" },
      {
        "gi",
        function()
          require("telescope.builtin").lsp_implementations({
            file_ignore_patterns = { "[^a-z]mock[^a-z]", "Mock[^a-z]" },
          })
        end,
        desc = "Goto Implementations",
      },
      {
        "<leader>g",
        function()
          require("telescope").extensions.live_grep_args.live_grep_args()
        end,
        desc = "Grep Strings",
      },
      {
        "<leader>fs",
        function()
          require("telescope.builtin").lsp_document_symbols({
            symbols = {
              "constant",
              "interface",
              "function",
              "method",
              "struct",
            },
            symbol_width = 50,
          })
        end,
        desc = "Find Symbols",
      },
      { "gb", "<cmd>Telescope git_branches<CR>", desc = "Find Git Branches" },
    },
    opts = {
      defaults = {
        file_ignore_patterns = { "%_test.go" },
        mappings = {
          i = {
            ["<C-d>"] = function(prompt_bufnr)
              return require("telescope.actions.set").shift_selection(prompt_bufnr, 4)
            end,
            ["<C-u>"] = function(prompt_bufnr)
              return require("telescope.actions.set").shift_selection(prompt_bufnr, -4)
            end,
            ["<C-j>"] = require("telescope.actions").preview_scrolling_down,
            ["<C-k>"] = require("telescope.actions").preview_scrolling_up,
          },
        },
      },
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
