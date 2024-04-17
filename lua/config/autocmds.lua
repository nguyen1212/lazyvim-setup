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

    -- lsp highlight
    vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", {
      -- bg = "#0000ff"
      bold = true,
      italic = true,
      -- underline = true,
    })

    -- neotree highlight
    local neotree_normal_hl_id = vim.fn.hlID("NeoTreeNormal")
    local neotree_normal_bg = vim.fn.synIDattr(neotree_normal_hl_id, "bg#")

    vim.api.nvim_set_hl(0, "NeoTreeFloatNormal", { link = "Normal" })
    vim.api.nvim_set_hl(0, "NeoTreeFloatBorder", { link = "Normal" })
    vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", {
      bg = neotree_normal_bg,
      fg = neotree_normal_bg,
    })

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
    local tl_border_hl = vim.fn.hlID("TelescopeBorder")
    local tl_border_fg = vim.fn.synIDattr(tl_border_hl, "fg#")
    local tl_prompt_border_hl = vim.fn.hlID("TelescopePromptBorder")
    local tl_prompt_border_fg = vim.fn.synIDattr(tl_prompt_border_hl, "fg#")
    vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = normal_bg })
    vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = tl_border_fg, bg = normal_bg })
    vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = tl_prompt_border_fg, bg = normal_bg })
    vim.api.nvim_set_hl(0, "TelescopePromptTitle", { link = "TelescopePromptBorder" })

    -- number highlight
    vim.api.nvim_set_hl(0, "LineNr", { link = "qfLineNr" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { link = "Normal" })

    -- popup menu highlight
    vim.api.nvim_set_hl(0, "Pmenu", { bg = "#46484A" })
    vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#4f86c9" })
    vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "#46484A" })
    vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#30619c" })

    -- treesitter context
    vim.api.nvim_set_hl(0, "TreesitterContext", {
      bg = "#16161e",
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
