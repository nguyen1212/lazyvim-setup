return {
  -- debuggee
  {
    "leoluz/nvim-dap-go",
    dependencies = { "mfussenegger/nvim-dap" },
    lazy = true,
    enabled = true,
    -- opts = function(_, opts)
    --   opts = opts or {}
    --
    --   opts.dap_configurations = {
    --     {
    --       type = "go",
    --       name = "Debug Server",
    --       request = "launch",
    --       program = os.getenv("SERVER_DIR"), -- Must set SERVER_DIR in env
    --     },
    --   }
    --
    --   table.insert(opts.delve, {
    --     port = os.getenv("SERVER_PORT"), -- Must set SERVER_PORT in env
    --   })
    -- end,
    opts = {
      -- dap_configurations = {
      --   {
      --     name = "Debug Server",
      --     type = "go",
      --     request = "launch",
      --     mode = "debug",
      --     program = os.getenv("SERVER_DIR"), -- Must set SERVER_DIR in env
      --   },
      -- },
      delve = {
        port = os.getenv("SERVER_PORT"), -- Must set SERVER_PORT in env
      },
      dap_configurations = {
        {
          type = "go",
          name = "Attach Server",
          mode = "remote",
          request = "attach",
          program = os.getenv("SERVER_DIR"), -- Must set SERVER_DIR in env
          port = os.getenv("SERVER_PORT"), -- Must set SERVER_PORT in env
        },
      },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    lazy = true,
    keys = {
      {
        "<leader>dr",
        function()
          local dapui = require("dapui")

          ---@diagnostic disable-next-line: missing-fields
          dapui.float_element("repl", {
            enter = true,
            width = 100,
            height = 50,
          })
        end,
        silent = true,
      },
    },
    opts = {
      layouts = {
        {
          elements = {
            {
              id = "breakpoints",
              size = 0.50,
            },
            {
              id = "console",
              size = 0.50,
            },
          },
          position = "left",
          size = 50,
        },
        {
          elements = {
            {
              id = "scopes",
              size = 1,
            },
          },
          position = "bottom",
          size = 20,
        },
      },
    },
  },

  -- testing
  {
    "andythigpen/nvim-coverage",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ct", "<cmd>CoverageLoad<cr><cmd>CoverageToggle<CR>", desc = "Coverage in gutter" },
      { "<leader>cs", "<cmd>CoverageLoad<cr><cmd>CoverageSummary<cr>", desc = "Coverage summary" },
    },
    opts = {
      auto_reload = true,
      lang = {
        go = {
          coverage_file = vim.fn.getcwd() .. "/coverage.out",
        },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    enabled = false,
    keys = {
      { "<leader>tl", false },
      { "<leader>tn", "<cmd>Neotest jump next<CR>", { silent = true, desc = "Next test" } },
      { "<leader>tp", "<cmd>Neotest jump prev<CR>", { silent = true, desc = "Prev test" } },
      -- { "<leader>tc", "<cmd>Neotest output-panel clear<CR>", { silent = true, desc = "Clear test output" } },
    },
  },
  {
    "nvim-neotest/neotest-go",
    enabled = false,
    dependencies = "nvim-neotest/neotest",
    keys = {
      {
        "<leader>tc",
        function()
          ---@diagnostic disable-next-line: missing-fields
          require("neotest").run.run({
            vim.fn.expand("%"),
            extra_args = { "-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out" },
          })
        end,
        {
          desc = "Run neareast test",
          silent = true,
          remap = true,
        },
      },
    },
  },
  {
    "quolpr/quicktest.nvim",
    config = function()
      local qt = require("quicktest")

      qt.setup({
        -- Choose your adapter, here all supported adapters are listed
        adapters = {
          require("quicktest.adapters.golang")({
            additional_args = function(bufnr)
              return {
                "-race",
                "-count=1",
                "-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
              }
            end,
            -- bin = function(bufnr) return 'go' end
            -- cwd = function(bufnr) return 'your-cwd' end
          }),
          -- require("quicktest.adapters.vitest"),
          -- require("quicktest.adapters.elixir"),
          -- require("quicktest.adapters.criterion"),
        },
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "m00qek/baleia.nvim",
    },
    keys = {
      {
        "<leader>tr",
        function()
          local qt = require("quicktest")
          -- current_win_mode return currently opened panel, split or popup
          qt.run_line("split")
          -- You can force open split or popup like this:
          -- qt().run_current("split")
          -- qt().run_current('popup')
        end,
        desc = "[T]est [R]un",
      },
      {
        "<leader>tR",
        function()
          local qt = require("quicktest")

          qt.run_file("split")
        end,
        desc = "[T]est [R]un file",
      },
      {
        "<leader>td",
        function()
          local qt = require("quicktest")

          qt.run_dir("split")
        end,
        desc = "[T]est Run [D]ir",
      },
      {
        "<leader>ta",
        function()
          local qt = require("quicktest")

          qt.run_all("split")
        end,
        desc = "[T]est Run [A]ll",
      },
      {
        "<leader>tp",
        function()
          local qt = require("quicktest")

          qt.run_previous("split")
        end,
        desc = "[T]est Run [P]revious",
      },
      {
        "<leader>tt",
        function()
          local qt = require("quicktest")

          qt.toggle_win("split")
        end,
        desc = "[T]est Toggle [S]plit window",
      },
    },
  },

  -- comment
  {
    { "LudoPinelli/comment-box.nvim" },
  },

  -- search & replace
  {
    "MagicDuck/grug-far.nvim",
    opts = {
      engines = {
        ripgrep = {
          extraArgs = "--multiline",
        },
      },
    },
    keys = {
      {
        "<leader>sr",
        mode = { "n", "v" },
        function()
          local filename = vim.fn.expand("%:.")
          -- local fileExt = vim.fn.expand("%:e")

          require("grug-far").toggle_instance({
            startInInsertMode = false,
            instanceName = "normal-search",
            transient = true,
            prefills = {
              search = vim.fn.expand("<cword>"),
              filesFilter = filename or nil,
            },
          })
        end,
        silent = true,
      },
    },
  },

  -- refactor
  {
    "ThePrimeagen/refactoring.nvim",
    enabled = false,
    opts = {
      prompt_func_return_type = {
        go = true,
      },
      prompt_func_param_type = {
        go = true,
      },
    },
  },

  -- aider
  {
    "joshuavial/aider.nvim",
    enabled = false,
    opts = {
      -- your configuration comes here
      -- if you don't want to use the default settings
      auto_manage_context = true, -- automatically manage buffer context
      default_bindings = true, -- use default <leader>A keybindings
      debug = true, -- enable debug logging
    },
  },
}
