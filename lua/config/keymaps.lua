-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local silentOpt = { silent = true }

-- navigate cursor
vim.keymap.set({ "n", "v" }, "0", "$")
vim.keymap.set({ "n", "v" }, "9", "0")
vim.keymap.set("i", "<C-o>", "<C-o>w", { noremap = true })
vim.keymap.set("i", "<C-i>", "<C-o>b", { noremap = false })
vim.keymap.set("i", "<C-h>", "<Left>", { remap = true })
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-k>", "<Up>", { remap = true })
vim.keymap.set("i", "<C-j>", "<Down>")

-- move text and block
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", silentOpt)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", silentOpt)

-- navigate screen
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join below line" })
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- copy to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set("n", "<leader>cd", function()
  local current_dir = vim.fn.expand("%:p:h")

  -- Determine the appropriate clipboard command based on the operating system
  local clipboard_command
  if vim.fn.has("mac") == 1 then
    clipboard_command = "pbcopy"
  elseif vim.fn.has("unix") == 1 then
    clipboard_command = "xclip -selection clipboard"
  elseif vim.fn.has("win32") == 1 then
    clipboard_command = "clip"
  else
    print("Unsupported OS")
    return
  end

  -- Copy the current directory to the clipboard
  vim.fn.system(clipboard_command, current_dir)
end)

-- operate without cut
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set({ "n", "v" }, "<leader><S-d>", [["_dd]])
vim.keymap.set({ "n", "v" }, "<leader>c", [["_c]])
vim.keymap.set({ "n", "v" }, "<leader>p", [["_dP]])

-- buffer (use shift to remove delay because of other keymap)
vim.keymap.set("n", "<S-l>", ":bnext<CR>", silentOpt)
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", silentOpt)
vim.keymap.set("n", "<leader>bo", ":%bd|e#<cr>", { silent = true, desc = "Delete other buffers" })
vim.keymap.set("n", "<leader>ae", function()
  local filePath = vim.fn.expand("%<")
  local fileExt = vim.fn.expand("%:e")

  if string.find(filePath, "_test") then
    local originFile = string.gsub(filePath, "_test", "")
    originFile = originFile .. "." .. fileExt
    vim.cmd(":e " .. originFile)

    return
  end

  local testFile = filePath .. "_test." .. fileExt
  vim.cmd(":e " .. testFile)
end, { silent = true, desc = "Toggle test file" })
vim.keymap.set("n", "<leader>av", function()
  local filePath = vim.fn.expand("%<")
  local fileExt = vim.fn.expand("%:e")

  if string.find(filePath, "_test") then
    local originFile = string.gsub(filePath, "_test", "")
    originFile = originFile .. "." .. fileExt
    vim.cmd(":vsplit " .. originFile)

    return
  end

  local testFile = filePath .. "_test." .. fileExt
  vim.cmd(":vsplit " .. testFile)
end, { silent = true, desc = "Open test file in vsplit" })

-- Resize window using <ctrl> arrow keys
-- vim.keymap.set("n", "<S-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
-- vim.keymap.set("n", "<S-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<S-Up>", "")
vim.keymap.set("n", "<S-Down>", "")
vim.keymap.set("n", "<D-S-Up>", "")
vim.keymap.set("n", "<D-S-Down>", "")
vim.keymap.set("n", "<S-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<S-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- quickfix
vim.keymap.set("n", "<leader>q", ":copen<CR>", silentOpt)
vim.keymap.set("n", "<leader>Q", ":cclose<CR>", silentOpt)

-- comment
vim.keymap.set("n", "<leader>/", "gcc", { remap = true, silent = true })
vim.keymap.set("v", "<leader>/", "gc", { remap = true, silent = true })

vim.keymap.set("n", "<C-a>", "ggVG", silentOpt)

-- session
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { remap = false })

-- diagnostic
vim.keymap.set("n", "<leader>rd", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { silent = true, desc = "Toggle diagnostic" })

-- Telescope ignore patterns
local telescope_ignore_patterns = {
  "[^a-z]test[^a-z]",
  "[^a-z]mock[^a-z]",
  -- "[^a-z]stub[^a-z]",
  "Test[^a-z]",
  "Mock[^a-z]",
  -- "Stub[^a-z]",
}

vim.keymap.set("n", "<leader>ft", function()
  vim.g.telescope_ignore_enabled = not vim.g.telescope_ignore_enabled

  require("telescope.config").set_defaults({
    file_ignore_patterns = vim.g.telescope_ignore_enabled and telescope_ignore_patterns or {},
  })
end, { noremap = true, desc = "Toggle telescope ignore patterns" })
