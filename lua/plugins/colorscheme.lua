return {
  {
    "folke/tokyonight.nvim",
    enabled = false,
    opts = {
      style = "night",
      light_style = "day",
    },
  },
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    -- flavour = "frappe",
    opts = {
      flaour = "macchiato",
      transparent_background = true,
      -- color_overrides = {
      --   macchiato = {
      --     text = "#F4CDE9",
      --     subtext1 = "#DEBAD4",
      --     subtext0 = "#C8A6BE",
      --     overlay2 = "#B293A8",
      --     overlay1 = "#9C7F92",
      --     overlay0 = "#866C7D",
      --     surface2 = "#705867",
      --     surface1 = "#5A4551",
      --     surface0 = "#44313B",
      --     base = "#352939",
      --     mantle = "#211924",
      --     crust = "#1a1016",
      --   },
      -- },
      integrations = {
        aerial = true,
        alpha = true,
        cmp = false,
        dashboard = true,
        flash = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },
  {
    "ellisonleao/gruvbox.nvim",
    enabled = false,
    opts = {
      italic = {
        strings = false,
      },
      inverse = true,
      contrast = "",
      transparent_mode = true,
    },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    enabled = false,
    opts = {
      enable = {
        transparency = true,
      },
      styles = {
        transparency = true,
      },
    },
  },
  {
    "olimorris/onedarkpro.nvim",
    enabled = false,
    priority = 1000, -- Ensure it loads first
  },
  {
    "diegoulloao/neofusion.nvim",
    enabled = false,
    priority = 1000,
    config = true,
    opts = {
      transparent_mode = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
