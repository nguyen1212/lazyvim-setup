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
            width = 40,
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
              id = "scopes",
              size = 1,
            },
          },
          position = "bottom",
          size = 30,
        },
        {
          elements = {
            {
              id = "breakpoints",
              size = 0.25,
            },
            {
              id = "stacks",
              size = 0.25,
            },
          },
          position = "left",
          size = 40,
        },
      },
    },
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
}
