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

  -- project management
  {
    "coffebar/neovim-project",
    opts = {
      projects = { -- define project roots
        "~/Project/go/src/github.com/moneyforwardvietnam/*",
        "~/.config/*",
      },
    },
    last_session_on_startup = false,
    dashboard_mode = true,
    init = function()
      -- enable saving the state of plugins in the session
      vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "nvim-telescope/telescope.nvim",
      },
      { "Shatur/neovim-session-manager" },
    },
    lazy = false,
    priority = 100,
  },
  {
    "Shatur/neovim-session-manager",
    config = function(_, opts)
      local config = require("session_manager.config")
      opts.autoload_mode = config.AutoloadMode.CurrentDir
      require("session_manager").setup(opts)
    end,
  },
  {
    "folke/persistence.nvim",
    enabled = false,
  },
}
