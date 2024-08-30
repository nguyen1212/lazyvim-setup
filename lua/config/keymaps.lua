-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local silentOpt = { silent = true }

-- navigate cursor
vim.keymap.set({ "n", "v" }, "0", "$")
vim.keymap.set({ "n", "v" }, "9", "0", { noremap = true })
vim.keymap.set("i", "<C-o>", "<C-o>w", { noremap = true })
vim.keymap.set("i", "<C-b>", "<C-o>b", { noremap = false })
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

-- ── Image mappings ──────────────────────────────────────────────────
-- open image in Finder
vim.keymap.set("n", "<leader>if", function()
  local function get_image_path()
    -- Get the current line
    local line = vim.api.nvim_get_current_line()
    -- Pattern to match image path in Markdown
    local image_pattern = "%[.-%]%((.-)%)"
    -- Extract relative image path
    local _, _, image_path = string.find(line, image_pattern)
    return image_path
  end
  -- Get the image path
  local image_path = get_image_path()
  if image_path then
    -- Check if the image path starts with "http" or "https"
    if string.sub(image_path, 1, 4) == "http" then
      print("URL image, use 'gx' to open it in the default browser.")
    else
      -- Construct absolute image path
      local current_file_path = vim.fn.expand("%:p:h")
      local absolute_image_path = current_file_path .. "/" .. image_path
      -- Open the containing folder in Finder and select the image file
      local command = "open -R " .. vim.fn.shellescape(absolute_image_path)
      local success = vim.fn.system(command)
      if success == 0 then
        print("Opened image in Finder: " .. absolute_image_path)
      else
        print("Failed to open image in Finder: " .. absolute_image_path)
      end
    end
  else
    print("No image found under the cursor")
  end
end, { desc = "[P](macOS) Open image under cursor in Finder" })

-- paste image from clipboard
vim.keymap.set({ "n" }, "<leader>ip", function()
  local pasted_image = require("img-clip").paste_image()
  if pasted_image then
    -- "Update" saves only if the buffer has been modified since the last save
    vim.cmd("silent! update")
    -- Get the current line
    local line = vim.api.nvim_get_current_line()
    -- Move cursor to end of line
    vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1], #line })
    -- I reload the file, otherwise I cannot view the image after pasted
    vim.cmd("edit!")
  end
end, { desc = "[P]Paste image from system clipboard" })

-- delete image under cursor
vim.keymap.set("n", "<leader>id", function()
  local function get_image_path()
    local line = vim.api.nvim_get_current_line()
    local image_pattern = "%[.-%]%((.-)%)"
    local _, _, image_path = string.find(line, image_pattern)
    return image_path
  end
  local image_path = get_image_path()
  if not image_path then
    vim.api.nvim_echo({ { "No image found under the cursor", "WarningMsg" } }, false, {})
    return
  end
  if string.sub(image_path, 1, 4) == "http" then
    vim.api.nvim_echo({ { "URL image cannot be deleted from disk.", "WarningMsg" } }, false, {})
    return
  end
  local current_file_path = vim.fn.expand("%:p:h")
  local absolute_image_path = current_file_path .. "/" .. image_path
  -- Check if file exists
  if vim.fn.filereadable(absolute_image_path) == 0 then
    vim.api.nvim_echo(
      { { "Image file does not exist:\n", "ErrorMsg" }, { absolute_image_path, "ErrorMsg" } },
      false,
      {}
    )
    return
  end
  if vim.fn.executable("trash") == 0 then
    vim.api.nvim_echo({
      { "- Trash utility not installed. Make sure to install it first\n", "ErrorMsg" },
      { "- In macOS run `brew install trash`\n", nil },
    }, false, {})
    return
  end
  -- Cannot see the popup as the cursor is on top of the image name, so saving
  -- its position, will move it to the top and then move it back
  local current_pos = vim.api.nvim_win_get_cursor(0) -- Save cursor position
  vim.api.nvim_win_set_cursor(0, { 1, 0 }) -- Move to top
  vim.ui.select({ "yes", "no" }, { prompt = "Delete image file? " }, function(choice)
    vim.api.nvim_win_set_cursor(0, current_pos) -- Move back to image line
    if choice == "yes" then
      local success, _ = pcall(function()
        vim.fn.system({ "trash", vim.fn.fnameescape(absolute_image_path) })
      end)
      -- Verify if file still exists after deletion attempt
      if success and vim.fn.filereadable(absolute_image_path) == 1 then
        -- Try with rm if trash deletion failed
        -- Keep in mind that if deleting with `rm` the images won't go to the
        -- macos trash app, they'll be gone
        -- This is useful in case trying to delete imaes mounted in a network
        -- drive, like for my blogpost lamw25wmal
        --
        -- Cannot see the popup as the cursor is on top of the image name, so saving
        -- its position, will move it to the top and then move it back
        current_pos = vim.api.nvim_win_get_cursor(0) -- Save cursor position
        vim.api.nvim_win_set_cursor(0, { 1, 0 }) -- Move to top
        vim.ui.select({ "yes", "no" }, { prompt = "Trash deletion failed. Try with rm command? " }, function(rm_choice)
          vim.api.nvim_win_set_cursor(0, current_pos) -- Move back to image line
          if rm_choice == "yes" then
            local rm_success, _ = pcall(function()
              vim.fn.system({ "rm", vim.fn.fnameescape(absolute_image_path) })
            end)
            if rm_success and vim.fn.filereadable(absolute_image_path) == 0 then
              vim.api.nvim_echo({
                { "Image file deleted from disk using rm:\n", "Normal" },
                { absolute_image_path, "Normal" },
              }, false, {})
              -- require("image").clear()
              vim.cmd("edit!")
              vim.cmd("normal! dd")
            else
              vim.api.nvim_echo({
                { "Failed to delete image file with rm:\n", "ErrorMsg" },
                { absolute_image_path, "ErrorMsg" },
              }, false, {})
            end
          end
        end)
      elseif success and vim.fn.filereadable(absolute_image_path) == 0 then
        vim.api.nvim_echo({
          { "Image file deleted from disk:\n", "Normal" },
          { absolute_image_path, "Normal" },
        }, false, {})
        -- require("image").clear()
        vim.cmd("edit!")
        vim.cmd("normal! dd")
      else
        vim.api.nvim_echo({
          { "Failed to delete image file:\n", "ErrorMsg" },
          { absolute_image_path, "ErrorMsg" },
        }, false, {})
      end
    else
      vim.api.nvim_echo({ { "Image deletion canceled.", "Normal" } }, false, {})
    end
  end)
end, { desc = "[P](macOS) Delete image file under cursor" })

-- ──────────────────────────────────────────────────────────────────────
