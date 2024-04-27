return {
  -- debuggee
  {
    "leoluz/nvim-dap-go",
    dependencies = { "mfussenegger/nvim-dap" },
    lazy = true,
    enabled = true,
    opts = {
      dap_configurations = {
        {
          type = "go",
          name = "Debug Server",
          request = "launch",
          program = os.getenv("SERVER_DIR"), -- Must set SERVER_DIR in env
        },
      },
      delve = {
        port = os.getenv("SERVER_PORT"), -- Must set SERVER_PORT in env
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
            width = 50,
            height = 30,
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
    keys = {
      { "<leader>tl", false },
      { "<leader>tn", "<cmd>Neotest jump next<CR>", { silent = true, desc = "Next test" } },
      { "<leader>tp", "<cmd>Neotest jump prev<CR>", { silent = true, desc = "Prev test" } },
      -- { "<leader>tc", "<cmd>Neotest output-panel clear<CR>", { silent = true, desc = "Clear test output" } },
    },
  },
  {
    "nvim-neotest/neotest-go",
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

  -- project management
  {
    "coffebar/neovim-project",
    enabled = false,
    opts = {
      last_session_on_startup = true,
      dashboard_mode = true,
      projects = { -- define project roots
        "~/*",
        "~/Project/go/src/github.com/moneyforwardvietnam/*",
        "~/.config/*",
      },
    },
    init = function()
      -- enable saving the state of plugins in the session
      vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "nvim-telescope/telescope.nvim",
      },
    },
    keys = {
      {
        "<leader>qd",
        function()
          require("session_manager").delete_session()
        end,
        silent = true,
        desc = "Delete session",
      },
    },
    lazy = false,
    priority = 100,
  },

  --refactoring
  {
    "ThePrimeagen/refactoring.nvim",
    opts = {
      prompt_func_return_type = {
        go = false,
      },
      prompt_func_param_type = {
        go = false,
      },
    },
  },

  -- {
  --   "ThePrimeagen/harpoon",
  --   branch = "harpoon2",
  --   dependencies = "nvim-telescope/telescope.nvim",
  --   keys = {
  --     {
  --       "<leader>Hc",
  --       function()
  --         require("harpoon"):list():clear()
  --       end,
  --     },
  --   },
  --   config = function()
  --     require("telescope").load_extension("harpoon")
  --   end,
  -- },
}
