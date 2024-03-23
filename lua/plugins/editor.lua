return {
  {
    "folke/flash.nvim",
    enabled = false,
  },
  {
    -- terminal
    "akinsho/toggleterm.nvim",
    keys = {
      {
        "<leader>tl",
        "<Cmd>TermSelect<CR>",
        mode = { "n", "t" },
        silent = true,
      },
      {
        "<S-Tab>",
        function()
          local count = vim.v.count
          local countName = count

          if countName == 0 then
            countName = countName + 1
          end

          local termName = string.format("Terminal %d", countName)

          vim.cmd(string.format("exe %d 'ToggleTerm name=\"%s\"'", count, termName))
        end,
        mode = { "i", "n", "t" },
        silent = true,
      },
      { "<Esc>", [[ <C-\><C-n> ]], mode = { "t" }, silent = true },
    },
    opts = {
      direction = "float",
      shade_terminal = false,
      on_create = function(term)
        term.name = term.name or ("Terminal " .. tostring(term.id))
        term.display_name = term.display_name or ("Terminal " .. tostring(term.id))
      end,
      highlights = {
        -- highlights which map to a highlight group name and a table of it's values
        -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
        FloatBorder = {
          link = "Constant",
          -- guifg = "#27a1b9",
          -- guibg = "#16161e",
          guibg = "NONE",
        },
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
    lazy = true,
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
          -- view = "notify",
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
    init = function() end,
  },
  opts = {
    bind_to_cwd = false,
  },

  -- split join
  {
    "echasnovski/mini.splitjoin",
    version = "*",
    config = function(_, opts)
      local sj = require("mini.splitjoin")

      local gen_hook = sj.gen_hook
      local bracket = { brackets = { "%b()", "%b[]", "%b{}" } }
      -- local bracket = { brackets = {} }

      -- add trailing comma when split brackets
      local add_comma = gen_hook.add_trailing_separator(bracket)

      -- delete trailing comma when joining inside brackets
      local del_comma = gen_hook.del_trailing_separator(bracket)

      opts.split = { hooks_post = { add_comma } }
      opts.join = { hooks_post = { del_comma } }
      opts.mappings = {
        toggle = "",
        split = "gS",
        join = "gJ",
      }

      sj.setup(opts)
    end,
  },

  -- disable tabline
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },

  -- csv
  {
    "cameron-wags/rainbow_csv.nvim",
    lazy = true,
    config = true,
    ft = {
      "csv",
      "tsv",
      "csv_semicolon",
      "csv_whitespace",
      "csv_pipe",
      "rfc_csv",
      "rfc_semicolon",
    },
    cmd = {
      "RainbowDelim",
      "RainbowDelimSimple",
      "RainbowDelimQuoted",
      "RainbowMultiDelim",
    },
  },
}
