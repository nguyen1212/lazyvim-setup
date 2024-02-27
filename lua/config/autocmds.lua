-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    -- selection
    vim.cmd([[hi Visual cterm=NONE guibg=#4f86c9]])

    -- comment
    vim.cmd([[hi Comment term=bold  guifg=LightGreen]])

    -- set diff relative to base
    vim.cmd([[ let g:gitgutter_diff_base = 'head' | ":GitGutter<CR>" ]])

    -- vim.cmd([[ syntax on ]])
    -- vim.cmd([[ set re=0 ]])
    -- vim.cmd([[ lang en_US.UTF-8 ]])

    -- popup menu
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#46484A" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#46484A" })
    vim.api.nvim_set_hl(0, "Pmenu", { bg = "#46484A" })
    vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#4f86c9" })
    vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "#46484A" })
    vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#30619c" })

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
