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
        "<S-h>",
        false,
        function()
          local ui = require("toggleterm.ui")
          local terms = require("toggleterm.terminal").get_all(true)

          local isAnyOpen = false

          for _, v in pairs(terms) do
            isAnyOpen = isAnyOpen or ui.term_has_open_win(v)
          end

          if not isAnyOpen then
            return "<S-h>"
          end

          if #terms == 1 then
            return
          end

          local term_id = require("toggleterm.terminal").get_focused_id()
          local next_term_id = term_id - 1

          if term_id == 1 then
            next_term_id = #terms
          end

          vim.cmd(string.format("exe %d 'ToggleTerm'", next_term_id))

          -- Switch to terminal mode in the current buffer
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("i", true, true, true), "n", true)
        end,
        mode = { "t", "n" },
        silent = true,
      },
      {
        "<S-l>",
        false,
        function()
          local ui = require("toggleterm.ui")
          local terms = require("toggleterm.terminal").get_all(true)

          local isAnyOpen = false

          for _, v in pairs(terms) do
            isAnyOpen = isAnyOpen or ui.term_has_open_win(v)
          end

          if not isAnyOpen then
            return "<S-h>"
          end

          if #terms == 1 then
            return
          end

          local term_id = require("toggleterm.terminal").get_focused_id()
          local next_term_id = term_id + 1

          if term_id == #terms then
            next_term_id = 1
          end

          vim.cmd(string.format("exe %d 'ToggleTerm'", next_term_id))

          -- Switch to terminal mode in the current buffer
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("i", true, true, true), "n", true)
        end,
        mode = { "t", "n" },
        silent = true,
      },
      {
        "<S-Tab>",
        function()
          local count = vim.v.count
          local countName = count
          local terms = require("toggleterm.terminal").get_all(true)

          if count == 0 then
            countName = count + 1
          end

          if count <= #terms and #terms > 0 then
            vim.cmd(string.format("exe %d 'ToggleTerm'", count))

            return
          end

          local term_name = ""

          for k, v in pairs(terms) do
            term_name = term_name .. " "

            term_name = term_name .. v.name

            if k == #terms then
              term_name = term_name .. " "
            end
          end

          if #terms > 0 then
            term_name = term_name .. "[Terminal " .. countName .. "] "
          else
            term_name = term_name .. " [Terminal " .. countName .. "] "
          end

          vim.cmd(string.format("exe %d 'ToggleTerm name=\"%s\"'", count, term_name))
        end,
        mode = { "i", "n", "t" },
        silent = true,
      },
      { "<Esc>", [[ <C-\><C-n> ]], mode = { "t" }, silent = true },
    },
    opts = {
      direction = "float",
      shade_terminal = false,
      start_in_insert = true,
      on_create = function(term)
        term.display_name = ("Terminal " .. tostring(term.id))
        term.name = term.display_name
      end,
      on_open = function(term)
        local terms = require("toggleterm.terminal").get_all(true)
        local terms_display_name = ""

        for k, v in pairs(terms) do
          terms_display_name = terms_display_name .. " "

          if k == term.id then
            terms_display_name = terms_display_name .. "["
          end

          terms_display_name = terms_display_name .. v.name

          if k == term.id then
            terms_display_name = terms_display_name .. "]"
          end

          if k == #terms then
            terms_display_name = terms_display_name .. " "
          end
        end

        term.display_name = terms_display_name
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
    enabled = true,
    opts = {
      triggers = {
        { "<leader>b", mode = { "n" }, desc = "Buffer" },
        { "<leader>g", mode = { "n" }, desc = "Git" },
        { "<localleader>", mode = { "n" }, desc = "Local Leader" },
        { "g", desc = "Goto" },
      },
    },
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
      { "<c-f>", false },
      { "<c-b>", false },
      {
        "<c-j>",
        function()
          if not require("noice.lsp").scroll(4) then
            return "<c-w>j"
          end
        end,
        silent = true,
        expr = true,
        desc = "Scroll forward",
        mode = { "n", "s" },
      },
      {
        "<c-k>",
        function()
          if not require("noice.lsp").scroll(-4) then
            return "<c-w>k"
          end
        end,
        silent = true,
        expr = true,
        desc = "Scroll backward",
        mode = { "n", "s" },
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
    enabled = true,
    opts = function(_, opts)
      local icons = require("lazyvim.config").icons

      opts = opts or {}
      opts.options.globalstatus = true
      opts.sections.lualine_x = {
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = {fg=Snacks.util.color("Constant")},
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
            -- color = LazyVim.ui.fg("Debug"),
            color = {fg= Snacks.util.color("Debug")},
          },
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          -- color = LazyVim.ui.fg("Special"),
          color = { fg = Snacks.util.color("Special") },
        },
        -- {
        --   "diff",
        --   symbols = {
        --     added = icons.git.added,
        --     modified = icons.git.modified,
        --     removed = icons.git.removed,
        --   },
        --   source = function()
        --     ---@diagnostic disable-next-line: undefined-field
        --     local gitsigns = vim.b.gitsigns_status_dict
        --     if gitsigns then
        --       return {
        --         added = gitsigns.added,
        --         modified = gitsigns.changed,
        --         removed = gitsigns.removed,
        --       }
        --     end
        --   end,
        -- },
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
          -- color = LazyVim.ui.fg("Special"),
          color = { fg = Snacks.util.color("Special") },
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
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = true,
    opts = {
      indent = {
        char = "",
        tab_char = "",
      },
    },
  },
  -- typing practice
  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },

  -- image preview
  {
    "3rd/image.nvim",
    enabled = false,
    event = "VeryLazy",
    config = function(_, opts)
      opts = {
        backend = "kitty",
        processor = "magick_rock", -- or "magick_cli"
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            floating_windows = false, -- if true, images will be rendered in floating markdown windows
            filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
          },
          neorg = {
            enabled = true,
            filetypes = { "norg" },
          },
          typst = {
            enabled = true,
            filetypes = { "typst" },
          },
          html = {
            enabled = false,
          },
          css = {
            enabled = false,
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
        editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
        tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
        rocks = {
          hererocks = true,
        },
      }
      require("image").setup(opts)
    end,
  },
}
