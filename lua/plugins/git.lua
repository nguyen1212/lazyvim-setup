return {
  -- git
  {
    "FabijanZulj/blame.nvim",
    keys = {
      { "gB", "<cmd>BlameToggle window<CR>", desc = "Toggle git blame" },
      { "gbf", "<cmd>BlameToggle virtual<CR>", desc = "Toggle git blame float" },
    },
    config = function()
      require("blame").setup()
    end,
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      { "dfo", "<cmd>DiffviewOpen<CR>", desc = "Open diff view" },
      { "dfc", "<cmd>DiffviewClose<CR>", desc = "Close diff view" },
      { "dfh", "<cmd>DiffviewFileHistory<CR>", desc = "Open diff history" },
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
      map({ "n", "v" }, "ghs", ":Gitsigns stage_hunk<CR>", "Stage hunk")
      map({ "n", "v" }, "ghr", ":Gitsigns reset_hunk<CR>", "Reset hunk")
      map("n", "ghS", gs.stage_buffer, "Stage Buffer")
      map("n", "ghu", gs.undo_stage_hunk, "Undo Stage hunk")
      map("n", "ghR", gs.reset_buffer, "Reset Buffer")
      map("n", "ghp", gs.preview_hunk_inline, "Preview hunk Inline")
      map("n", "ghb", function() gs.blame_line({ full = true }) end, "Blame line")
      map("n", "ghd", gs.diffthis, "Diff This")
      map("n", "ghD", function() gs.diffthis("~") end, "Diff This ~")
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select hunk")
      end,
    },
  },
}
