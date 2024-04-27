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

  -- file management
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
    keys = {
      { "<leader>e", false },
      { "<Tab>d", ":Neotree action=focus dir=", desc = "Neotree focus dir", silent = false },
      { "<Tab>f", ":Neotree action=focus reveal_force_cwd<CR>", desc = "Neotree focus file", silent = true },
      { "<Tab>t", ":Neotree toggle=true<CR>", desc = "Neotree toggle", silent = true },
      { "<Tab>g", ":Neotree float git_status git_base=HEAD<CR>", desc = "Neotree git status", silent = true },
    },
  },
  {
    "echasnovski/mini.files",
    opts = {
      windows = {
        preview = false,
        width_focus = 40,
      },
      options = {
        use_as_default_explorer = true,
      },
    },
    keys = {
      {
        "<leader>fm",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open mini.files (Directory of Current File)",
      },
      {
        "<leader>fM",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "Open mini.files (cwd)",
      },
    },
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

  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local icons = require("lazyvim.config").icons

      opts = opts or {}
      opts.sections.lualine_x = {
          -- stylua: ignore
          -- {
          --   function() return require("noice").api.status.mode.get() end,
          --   cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
          --   color = LazyVim.ui.fg("Constant"),
          -- },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = LazyVim.ui.fg("Debug"),
          },
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = LazyVim.ui.fg("Special"),
        },
        {
          "diff",
          symbols = {
            added = icons.git.added,
            modified = icons.git.modified,
            removed = icons.git.removed,
          },
          source = function()
            ---@diagnostic disable-next-line: undefined-field
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
              return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
              }
            end
          end,
        },
      }
      opts.sections.lualine_y = {
        { "location", padding = { left = 0, right = 1 } },
      }
      opts.sections.lualine_z = {}
      opts.sections.lualine_c = {
        LazyVim.lualine.root_dir({
          ---@diagnostic disable-next-line: assign-type-mismatch
          cwd = true,
          subdirectory = true,
          parent = true,
          other = true,
          icon = "󱉭 ",
          color = LazyVim.ui.fg("Special"),
        }),
        {
          "diagnostics",
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
          },
        },
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        { LazyVim.lualine.pretty_path() },
      }

      return opts
    end,
  },
}
