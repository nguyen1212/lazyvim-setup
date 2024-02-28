return {
  -- git
  {
    "airblade/vim-gitgutter",
    keys = {
      { "]x", "<cmd>GitGutterNextHunk<CR>", desc = "Move to next hunk" },
      { "[x", "<cmd>GitGutterPrevHunk<CR>", desc = "Move to previous hunk" },
    },
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      { "dfo", "<cmd>DiffviewOpen<CR>", desc = "Open diff view" },
      { "dfc", "<cmd>DiffviewClose<CR>", desc = "Close diff view" },
    },
  },
}
