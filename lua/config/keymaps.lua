-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.g.mapleader = " "

-- navigate cursor
vim.keymap.set({ "n", "v" }, "0", "$")
vim.keymap.set({ "n", "v" }, "9", "0")
vim.keymap.set("i", "<C-h>", "<Home>")
vim.keymap.set("i", "<C-l>", "<End>")

-- move text and block
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- comment
vim.keymap.set({ "n", "v" }, "<leader>/", ":Commentary<CR>")
-- vim.keymap.set({ "i" }, "<leader>/", "<Esc>:Commentary<CR>")

-- navigate screen
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join below line" })
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- escape hlsearch
vim.keymap.set("v", "//", [[ y/\V<C-R>=escape(@",'/\')<CR><CR> ]])

-- terminal
vim.keymap.set({ "n", "t" }, "<S-Tab>", ":ToggleTerm<CR>")
vim.keymap.set("t", "<Esc>", [[ <C-\><C-n> ]])

-- copy to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- operate without cut
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set({ "n", "v" }, "<leader><S-d>", [["_dd]])
vim.keymap.set({ "n", "v" }, "<leader>c", [["_c]])
vim.keymap.set({ "n", "v" }, "<leader>p", [["_dP]])

-- buffer  (use shift to remove delay because of other keymap)
vim.keymap.set("n", "<S-l>", ":bnext<CR>")
vim.keymap.set("n", "<S-h>", ":bprevious<CR>")

-- vim.keymap.set("n", "<leader><S-d>", ":bdelete<CR>")
vim.keymap.set("n", "<leader>bo", "<cmd>%bd|e#<cr>", { desc = "Close all buffers but the current one" })

-- yank
vim.keymap.set("n", "<leader>yh", function()
  require("telescope").extensions.yank_history.yank_history({})
end, { desc = "Open Yank History" })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<S-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<S-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<S-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<S-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- neo tree
vim.keymap.set("n", "<Tab>d", ":Neotree action=focus dir=")
vim.keymap.set("n", "<Tab>f", ":Neotree action=focus reveal_force_cwd<CR>")
vim.keymap.set("n", "<Tab>t", ":Neotree toggle=true<CR>")
vim.keymap.set("n", "<Tab>g", ":Neotree float git_status git_base=HEAD<CR>")

-- telescope
vim.keymap.set("n", "<leader>ff", ":Telescope find_files hidden=true<CR>")
vim.keymap.set("n", "<leader>fg", ":Telescope git_files<CR>")
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>")
vim.keymap.set("n", "gr", ":Telescope lsp_references<CR>")
vim.keymap.set("n", "gy", ":Telescope lsp_type_definition<CR>")
vim.keymap.set("n", "gi", ":Telescope lsp_implementations<CR>")
vim.keymap.set("n", "<C-g>", function()
  require("telescope").extensions.live_grep_args.live_grep_args()
end)
vim.keymap.set("n", "<leader>g", ":Telescope grep_string<CR>")
vim.keymap.set("n", "<leader>ti", function()
  vim.g.telescope_ignore_enabled = not vim.g.telescope_ignore_enabled

  require("telescope.config").set_defaults({
    file_ignore_patterns = { "[^a-z]mock[^a-z]", "Mock[^a-z]" },
  })
end)
vim.keymap.set("n", "<leader>fs", function()
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
end)
-- vim.keymap.set("n", "<C-f>", function()
--   require("telescope.actions").preview_scrolling_left(2)
-- end)

vim.keymap.set("n", "gB", ":Git blame<CR>")
vim.keymap.set("n", "gb", ":Telescope git_branches<CR>")
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set("n", "]x", "<Plug>(GitGutterNextHunk)")
vim.keymap.set("n", "[x", "<Plug>(GitGutterPrevHunk)")
vim.keymap.set("n", "dfo", ":DiffviewOpen<CR>")
vim.keymap.set("n", "dfc", ":DiffviewClose<CR>")

-- quickfix
vim.keymap.set("n", "<leader>q", ":copen<CR>")
vim.keymap.set("n", "<leader>Q", ":cclose<CR>")

-- go setting
-- Navigation commands
vim.cmd([[ au FileType go nmap <leader>ds <plug>(go-def-split) ]])
vim.cmd([[ au FileType go nmap <leader>dv <plug>(go-def-vertical) ]])

-- Alternate commands
vim.cmd([[ au FileType go nmap <leader>ae <plug>(go-alternate-edit) ]])
vim.cmd([[ au FileType go nmap <leader>av <plug>(go-alternate-vertical) ]])
vim.cmd([[ au FileType go nmap <leader>aa :GoAlternate!<CR> ]])

-- Common Go commands
vim.cmd([[ au FileType go nmap <leader>ct :GoCoverageToggle<CR> ]])
vim.cmd([[ au FileType go nmap <leader>c :GoCoverage<CR> ]])
vim.cmd([[ au FileType go nmap <leader>t :GoTestFunc<CR> ]])
vim.cmd([[ au FileType go nmap <leader><S-t> :GoTestFile<CR> ]])
-- vim.cmd([[ au FileType go nmap gie <plug>(go-iferr) ]])
vim.cmd([[ au FileType go nmap gfs :GoFillStruct<CR> ]])
vim.cmd([[ au FileType go nmap gat :GoAddTags<CR> ]])
vim.cmd([[ au FileType go nmap gmr :GoModReload<CR> ]])

-- lsp
vim.keymap.set("n", "<S-k>", function()
  require("cmp.entry").get_documentation()
end)
