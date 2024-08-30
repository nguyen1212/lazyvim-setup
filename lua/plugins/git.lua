return {
  -- git
  {
    "sindrets/diffview.nvim",
    keys = {
      { "dfo", "<cmd>DiffviewOpen<CR>", desc = "Open diff view" },
      { "dfc", "<cmd>DiffviewClose<CR>", desc = "Close diff view" },
      { "dfh", "<cmd>DiffviewFileHistory --follow %<CR>", desc = "Open file history" },
      { "dph", "<cmd>DiffviewFileHistory<CR>", desc = "Open file history" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    keys = {
      { "]h", false },
      { "[h", false },
    },
    opts = {
      base = "@",
      diff_opts = {
        algorithm = "histogram",
        internal = true,
        indent_heuristic = true,
        vertical = true,
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, {
            buffer = buffer,
            desc = desc,
            remap = true,
            silent = true,
          })
        end

      -- stylua: ignore start
      map({"n", "x", "o"}, "]x", gs.next_hunk, "Next hunk")
      map({"n", "x", "o"}, "[x", gs.prev_hunk, "Prev hunk")
      map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
      map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
      map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
      map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
      map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
      map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
      map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
      map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
      map("n", "<leader>ghd", gs.diffthis, "Diff This")
      map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select hunk")
      end,
    },
  },
  {
    "pwntester/octo.nvim",
    opts = {
      users = "assignable",
      pull_requests = {
        always_select_remote_on_create = false,
      },
    },
    keys = {
      { "<leader>gp", false },
      { "<leader>gpl", "<cmd>Octo pr list<CR>", desc = "List PRs (Octo)" },
      { "<leader>gpc", "<cmd>Octo pr create<CR>", desc = "Create PRs (Octo)" },
    },
  },
}
