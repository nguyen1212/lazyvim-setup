-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    -- set to debug when needed
    vim.lsp.set_log_level("off")
    -- not move to next line if reach EOL | SOL
    vim.cmd([[set whichwrap=<,> ]])
    -- selection
    vim.cmd([[hi Visual cterm=NONE guibg=#366db0]])

    -- comment
    vim.cmd([[hi Comment term=bold  guifg=LightGreen]])

    -- diff
    -- vim.api.nvim_set_hl(0, "DiffChange", { link = "IncSearch" })

    -- lsp highlight
    vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", {
      -- bg = "#0000ff"
      bold = true,
      italic = true,
      -- underline = true,
    })
    vim.api.nvim_set_hl(0, "NoicePopup", { bg = "#46484A" })

    -- window highlight
    local normal_hl_id = vim.fn.hlID("Normal")
    local normal_bg = vim.fn.synIDattr(normal_hl_id, "bg#")
    vim.api.nvim_set_hl(0, "FloatBorder", {
      link = "Constant",
      bg = normal_bg,
    })
    vim.api.nvim_set_hl(0, "FloatTitle", { link = "FloatBorder" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#46484A" })
    vim.api.nvim_set_hl(0, "WinSeparator", { link = "Normal" })
    vim.api.nvim_set_hl(0, "DapUIFloatNormal", { link = "Normal" })

    -- telescope highlight
    -- local tl_border_hl = vim.fn.hlID("TelescopeBorder")
    -- local tl_border_fg = vim.fn.synIDattr(tl_border_hl, "fg#")
    -- local tl_prompt_border_hl = vim.fn.hlID("TelescopePromptBorder")
    -- local tl_prompt_border_fg = vim.fn.synIDattr(tl_prompt_border_hl, "fg#")
    -- vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = normal_bg })
    -- vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = tl_border_fg, bg = normal_bg })
    -- vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = tl_prompt_border_fg, bg = normal_bg })
    -- vim.api.nvim_set_hl(0, "TelescopePromptTitle", { link = "TelescopePromptBorder" })

    -- number highlight
    vim.api.nvim_set_hl(0, "LineNr", { fg = "#80827c" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { link = "Normal" })

    -- popup menu highlight
    vim.api.nvim_set_hl(0, "Pmenu", { bg = "#46484A" })
    vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#4f86c9" })
    vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "#46484A" })
    vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#30619c" })

    -- treesitter context
    vim.api.nvim_set_hl(0, "TreesitterContext", {
      -- bg = "#16161e",
      bg = "#0a1d2f",
      bold = true,
      default = false, -- set to true to respect existing default setting
    })

    -- cmp menu highlight
    vim.api.nvim_set_hl(0, "CmpDocNormalFloat", { bg = "#46484A" })
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
    vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", {
      bg = "NONE",
      strikethrough = true,
      fg = "#808080",
    })
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = "#569CD6" })
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpIntemAbbrMatch" })
    vim.api.nvim_set_hl(0, "CmpItemKindVariable", { bg = "NONE", fg = "#9CDCFE" })
    vim.api.nvim_set_hl(0, "CmpItemKindInterface", { link = "CmpItemKindVariable" })
    vim.api.nvim_set_hl(0, "CmpItemKindText", { link = "CmpItemKindVariable" })
    vim.api.nvim_set_hl(0, "CmpItemKindFunction", { bg = "NONE", fg = "#C586C0" })
    vim.api.nvim_set_hl(0, "CmpItemKindMethod", { link = "CmpItemKindFunction" })
    vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { bg = "NONE", fg = "#D4D4D4" })
    vim.api.nvim_set_hl(0, "CmpItemKindProperty", { link = "CmpItemKindKeyword" })
    vim.api.nvim_set_hl(0, "CmpItemKindUnit", { link = "CmpItemKindKeyword" })

    -- diagnostic
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", {
      sp = "Red",
      undercurl = true,
    })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", {
      sp = "Yellow",
      undercurl = true,
    })
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*_test.go",
  group = vim.api.nvim_create_augroup("_test_go_file", { clear = true }),
  callback = function()
    vim.diagnostic.enable(false, { bufnr = 0 })
    vim.treesitter.stop()
  end,
})

if vim.fn.argc(-1) == 0 then
  vim.cmd("do VimEnter")
end

-- Remove items from quickfix list.
-- `dd` to delete in Normal
-- `d` to delete Visual selection
vim.api.nvim_create_autocmd("FileType", {
  group = custom_group,
  pattern = "qf",
  callback = function()
    -- Do not show quickfix in buffer lists.
    vim.api.nvim_buf_set_option(0, "buflisted", false)

    -- Escape closes quickfix window.
    vim.keymap.set("n", "<ESC>", "<CMD>cclose<CR>", { buffer = true, remap = false, silent = true })

    local function delete_qf_items()
      local mode = vim.api.nvim_get_mode()["mode"]

      local start_idx
      local count

      if mode == "n" then
        -- Normal mode
        start_idx = vim.fn.line(".")
        count = vim.v.count > 0 and vim.v.count or 1
      else
        -- Visual mode
        local v_start_idx = vim.fn.line("v")
        local v_end_idx = vim.fn.line(".")

        start_idx = math.min(v_start_idx, v_end_idx)
        count = math.abs(v_end_idx - v_start_idx) + 1

        -- Go back to normal
        vim.api.nvim_feedkeys(
          vim.api.nvim_replace_termcodes(
            "<esc>", -- what to escape
            true, -- Vim leftovers
            false, -- Also replace `<lt>`?
            true -- Replace keycodes (like `<esc>`)?
          ),
          "x", -- Mode flag
          false -- Should be false, since we already `nvim_replace_termcodes()`
        )
      end

      local qflist = vim.fn.getqflist()

      for _ = 1, count, 1 do
        table.remove(qflist, start_idx)
      end

      vim.fn.setqflist(qflist, "r")
      vim.fn.cursor(start_idx, 1)
    end

    -- `dd` deletes an item from the list.
    vim.keymap.set("n", "dd", delete_qf_items, { buffer = true })
    vim.keymap.set("x", "d", delete_qf_items, { buffer = true })
  end,
  desc = "Quickfix tweaks",
})
