return {
  -- debuggee
  {
    "leoluz/nvim-dap-go",
    dependencies = { "mfussenegger/nvim-dap" },
    lazy = true,
    enabled = true,
    config = true,
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
    "theHamsta/nvim-dap-virtual-text",
    lazy = true,
    opts = {
      virt_text_pos = "overlay",
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

  -- test coverage
  {
    "andythigpen/nvim-coverage",
    dependencies = "nvim-lua/plenary.nvim",
    lazy = true,
    keys = {
      "<leader>tc",
      "<cmd>CoverageShow<CR>",
      silent = true,
      desc = "Show test coverage",
    },
    config = true,
  },
}