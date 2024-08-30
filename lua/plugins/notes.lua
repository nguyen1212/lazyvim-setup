local get_git_branch = function()
  -- local git = vim.fn.system("git branch --is-inside-work-tree 2> /dev/null")
  -- if git ~= "" then
  local branch = vim.fn.system("git branch --show-current | tr -d '\n'")
  return branch
  -- else
  --   return ""
  -- end
end

local get_project_name = function()
  local project_directory, err = vim.loop.cwd()
  if project_directory == nil then
    vim.notify(err, vim.log.levels.WARN)
    return nil
  end

  local project_name = vim.fs.basename(project_directory)
  if project_name == nil then
    vim.notify("Unable to get the project name", vim.log.levels.WARN)
    return nil
  end

  return project_name
end

return {
  {
    "backdround/global-note.nvim",
    keys = {
      {
        "<leader>vn",
        function()
          require("global-note").toggle_note("vim")

          vim.api.nvim_win_set_option(0, "winhighlight", "NormalFloat:Normal")
        end,
        silent = true,
      },
      {
        "<leader>n",
        function()
          require("global-note").toggle_note("git_branch_local")

          vim.api.nvim_win_set_option(0, "winhighlight", "NormalFloat:Normal")
        end,
        silent = true,
      },
      {
        "<leader><S-n>",
        function()
          require("global-note").toggle_note("project_local")

          vim.api.nvim_win_set_option(0, "winhighlight", "NormalFloat:Normal")
        end,
        silent = true,
      },
      {
        "<leader>sn",
        function()
          require("global-note").toggle_note("")

          vim.api.nvim_win_set_option(0, "winhighlight", "NormalFloat:Normal")
        end,
        silent = true,
      },
    },
    enable = true,
    config = function()
      require("global-note").setup({
        directory = "$HOME/Project/go-playground/notes/",
        window_config = function()
          local width = math.ceil(math.min(vim.o.columns, math.max(80, vim.o.columns - 20)))
          local height = math.ceil(math.min(vim.o.lines, math.max(20, vim.o.lines - 10)))

          local row = math.ceil(vim.o.lines - height) * 0.5 - 1
          local col = math.ceil(vim.o.columns - width) * 0.5 - 1

          return {
            relative = "editor",
            border = "single",
            title_pos = "left",
            width = width,
            height = height,
            row = row,
            col = col,
          }
        end,

        additional_presets = {
          vim = {
            command_name = "VimNote",
            filename = "nvim.md",
            title = "Vim Note",
          },
          project_local = {
            command_name = "ProjectNote",

            filename = function()
              return get_project_name() .. ".md"
            end,

            title = "Project note",
          },

          git_branch_local = {
            command_name = "GitBranchNote",

            directory = function()
              return "$HOME/Project/go-playground/notes/" .. get_project_name() .. "/"
            end,

            filename = function()
              local git_branch = get_git_branch()
              if git_branch == "" then
                return nil
              end
              return git_branch .. ".md"
            end,

            title = get_git_branch,
          },
        },
      })
    end,
  },
}
