return {
  {
    "folke/flash.nvim",
    enabled = false,
  },
  {
    -- terminal
    "akinsho/toggleterm.nvim",
    keys = {
      { "<S-Tab>", '<Cmd>exe v:count1 . "ToggleTerm"<CR>', mode = { "i", "n", "t" }, silent = true },
      { "<Esc>", [[ <C-\><C-n> ]], mode = { "t" }, silent = true },
    },
    opts = {
      direction = "float",
      shade_terminal = false,
      on_create = function(term)
        term.name = term.name or tostring(term.id)
        term.display_name = term.display_name or tostring(term.id)
      end,
      on_open = function(term)
        term.name = term.name or tostring(term.id)
        term.display_name = term.display_name or tostring(term.id)
      end,
    },
  },

  -- code comment
  {
    "tpope/vim-commentary",
    keys = {
      {
        "<leader>/",
        ":Commentary<CR>",
        mode = { "n", "v" },
        silent = true,
      },
    },
  },

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
        {
          filter = {
            event = "msg_show",
            kind = "",
            -- find = "written",
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = "msg_show",
            kind = "search_count",
          },
          view = "loading_notify",
        },
      },
      views = {
        notify = {
          replace = true,
        },
        loading_notify = {
          backend = "notify",
          fallback = "mini",
          format = "notify",
          replace = true,
          merge = true,
          -- timeout = 3,
        },
        done_notify = {
          backend = "notify",
          fallback = "mini",
          format = "notify",
          replace = true,
          merge = true,
          -- timeout = 5,
        },
      },
      lsp = {
        progress = {
          enabled = true,
          format = "lsp_progress",
          format_done = "lsp_progress_done",
          -- throttle = 1000 / 30,
          view = "notify",
        },
      },
    },
    keys = {
      {
        "<c-j>",
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
        "<c-k>",
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

  -- faster - disable slow plugin with large file
  "pteroctopus/faster.nvim",

  -- neo tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>e", false },
      { "<Tab>d", ":Neotree action=focus dir=", desc = "Neotree focus dir", silent = false },
      { "<Tab>f", ":Neotree action=focus reveal_force_cwd<CR>", desc = "Neotree focus file", silent = true },
      { "<Tab>t", ":Neotree toggle=true<CR>", desc = "Neotree toggle", silent = true },
      { "<Tab>g", ":Neotree float git_status git_base=HEAD<CR>", desc = "Neotree git status", silent = true },
    },
  },
  opts = {
    bind_to_cwd = false,
  },
}
