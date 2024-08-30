return {
  {
    "nvim-telescope/telescope.nvim",
    -- tag = "0.1.6",
    dependencies = {
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    -- override lsp keymap must be set at init function
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = {
        "gr",
        function()
          require("telescope.builtin").lsp_references({ file_ignore_patterns = { "%_test.go" } })
        end,
        desc = "Goto references",
      }
    end,
    keys = {
      { "<leader><leader>", false },
      { "<leader>/", false },
      -- {
      --   "<leader>ff",
      --   function(opts)
      --     opts = opts or {}
      --     -- always find files from top level dir of git
      --     local path = vim.loop.cwd() .. "/.git"
      --     local ok, _ = vim.loop.fs_stat(path)
      --     if ok then
      --       opts.cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
      --     end
      --     opts.hidden = false
      --     require("telescope.builtin").find_files(opts)
      --   end,
      --   desc = "Find files",
      -- },
      {
        "<leader>fh",
        "<cmd>Telescope find_files hidden=true<CR>",
        desc = "Find files (including hidden files)",
      },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find buffers" },
      { "<leader>fn", "<cmd>Telescope noice<CR>", desc = "Find noice history" },
      {
        "<leader>ff",
        function(opts)
          opts = opts or {}
          local cur_relative_path = LazyVim.root.get({ normalize = true })

          opts.cwd = cur_relative_path
          opts.hidden = false

          require("telescope.builtin").find_files(opts)
        end,
        desc = "Find Files (cwd)",
      },
      { "gy", "<cmd>Telescope lsp_type_definition<CR>", desc = "Goto type definition" },
      {
        "gi",
        function()
          require("telescope.builtin").lsp_implementations({
            file_ignore_patterns = { "[^a-z]mock[^a-z]", "Mock[^a-z]" },
          })
        end,
        desc = "Goto implementations",
      },
      {
        "<leader>fg",
        function(opts)
          opts = opts or {}
          local cur_relative_path = LazyVim.root.get({ normalize = true })

          opts.cwd = cur_relative_path
          opts.hidden = false
          require("telescope").extensions.live_grep_args.live_grep_args(opts)
        end,
        desc = "Grep strings",
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
        desc = "Find symbols",
      },
      -- {
      --   "<leader>h",
      --   function()
      --     vim.cmd("Telescope harpoon marks")
      --   end,
      --   desc = "Find harpoon marks",
      -- },
      { "gb", "<cmd>Telescope git_branches<CR>", desc = "Find git branches" },
    },
    opts = {
      defaults = {
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
            ["<C-h>"] = require("telescope.actions").preview_scrolling_left,
            ["<C-l>"] = require("telescope.actions").preview_scrolling_right,
          },
          n = {
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

  -- yanky
  {
    "gbprod/yanky.nvim",
    lazy = true,
    keys = {
      {
        -- yank
        "<leader>yh",
        function()
          require("telescope").extensions.yank_history.yank_history({})
        end,
        desc = "Open yank history",
        silent = true,
      },
    },
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
}
