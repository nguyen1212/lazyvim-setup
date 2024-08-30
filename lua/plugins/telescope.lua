return {
  {
    "nvim-telescope/telescope.nvim",
    -- tag = "0.1.6",
    dependencies = {
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    enabled = true,
    keys = {
      { "<leader><leader>", false },
      { "<leader>/", false },
      {
        "<leader>fn",
        function()
          local opts = {}

          opts.hidden = true
          opts.no_ignore = true
          opts.search_dirs = {
            "$HOME/Project/go-playground/notes/",
          }

          require("telescope.builtin").find_files(opts)
        end,
        { remap = false },
      },
      {
        "<leader>fh",
        function(opts)
          opts = opts or {}
          local cur_relative_path = LazyVim.root.get({ normalize = false })

          opts.search_dirs = { cur_relative_path }
          opts.hidden = true
          opts.no_ignore = true

          require("telescope.builtin").find_files(opts)
        end,
        desc = "Find files (including hidden files)",
      },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find buffers" },
      -- { "<leader>fn", "<cmd>Telescope noice<CR>", desc = "Find noice history" },
      -- { "<leader>ff", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      -- { "<leader>fF", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
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
      -- { "<leader>fg", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
      -- { "<leader>fG", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
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
      { "<leader>gb", "<cmd>Telescope git_branches<CR>", desc = "Find git branches" },
      {
        "<leader>gc",
        function()
          local previewers = require("telescope.previewers")
          local builtin = require("telescope.builtin")

          local delta = previewers.new_termopen_previewer({
            get_command = function(entry)
              return { "git", "-c", "core.pager=delta", "-c", "delta.side-by-side=true", "diff", entry.value .. "^!" }
            end,
          })

          local my_git_commits = function(opts)
            opts = opts or {}
            opts.previewer = delta

            builtin.git_commits(opts)
          end

          my_git_commits()
        end,
        desc = "Find git commits",
      },
      {
        "<leader>gs",
        function()
          local previewers = require("telescope.previewers")
          local builtin = require("telescope.builtin")

          local delta = previewers.new_termopen_previewer({
            get_command = function(entry)
              return { "git", "-c", "core.pager=delta", "-c", "delta.side-by-side=true", "diff", entry.value }
            end,
          })

          local my_git_status = function(opts)
            opts = opts or {}
            opts.previewer = delta

            builtin.git_status(opts)
          end

          my_git_status()
        end,
        desc = "Find git status",
      },
    },
    opts = {
      -- layout_strategy = "vertical",
      defaults = {
        path_display = {
          filename_first = {
            reverse_directories = true,
          },
        },
        layout_strategy = "vertical",
        layout_config = {
          vertical = {
            -- height = 1.5,
            preview_cutoff = 40,
            preview_height = 0.65,
            prompt_position = "top",
            -- width = 0.80,
          },
        },
        mappings = {
          i = {
            ["<C-j>"] = function(prompt_bufnr)
              return require("telescope.actions.set").shift_selection(prompt_bufnr, 1)
            end,
            ["<C-k>"] = function(prompt_bufnr)
              return require("telescope.actions.set").shift_selection(prompt_bufnr, -1)
            end,
            ["<C-d>"] = function(prompt_bufnr)
              return require("telescope.actions.set").shift_selection(prompt_bufnr, 5)
            end,
            ["<C-u>"] = function(prompt_bufnr)
              return require("telescope.actions.set").shift_selection(prompt_bufnr, -5)
            end,
            -- ["<C-d>"] = require("telescope.actions").preview_scrolling_down,
            -- ["<C-u>"] = require("telescope.actions").preview_scrolling_up,
            ["<C-h>"] = require("telescope.actions").preview_scrolling_left,
            ["<C-l>"] = require("telescope.actions").preview_scrolling_right,
          },
          n = {
            ["<C-j>"] = function(prompt_bufnr)
              return require("telescope.actions.set").shift_selection(prompt_bufnr, 4)
            end,
            ["<C-k>"] = function(prompt_bufnr)
              return require("telescope.actions.set").shift_selection(prompt_bufnr, -4)
            end,
            ["<C-d>"] = function(prompt_bufnr)
              return require("telescope.actions.set").shift_selection(prompt_bufnr, 5)
            end,
            ["<C-u>"] = function(prompt_bufnr)
              return require("telescope.actions.set").shift_selection(prompt_bufnr, -5)
            end,
            -- ["<C-d>"] = require("telescope.actions").preview_scrolling_down,
            -- ["<C-u>"] = require("telescope.actions").preview_scrolling_up,
            ["<C-a>"] = function(prompt_bufnr)
              local current_picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
              local i = 1
              for entry in current_picker.manager:iter() do
                current_picker._multi:toggle(entry)
                -- highlighting
                local row = current_picker:get_row(i)
                -- validate row is visible; otherwise result negative
                if row > 0 then
                  if current_picker:can_select_row(row) then
                    current_picker.highlighter:hi_multiselect(row, current_picker._multi:is_selected(entry))
                  end
                end
                i = i + 1
              end
            end,
            ["<S-q>"] = require("telescope.actions").send_selected_to_qflist + require("telescope.actions").open_qflist,
          },
        },
      },
    },
  },

  -- telescope frequency
  {
    "nvim-telescope/telescope-frecency.nvim",
    enabled = false,
    config = function()
      require("telescope").setup({
        extensions = {
          show_scores = true,
          frecency = {
            show_filter_column = false,
          },
        },
      })
      require("telescope").load_extension("frecency")
    end,
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
