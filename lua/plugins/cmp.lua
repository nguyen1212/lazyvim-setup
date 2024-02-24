return {
  -- completion
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
    },
    opts = function()
      -- cmp menu
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
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local defaults = require("cmp.config.default")()
      local types = require("cmp.types")
      return {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        preselect = types.cmp.PreselectMode.None,
        completion = {
          completeopt = "menu,menuone,noinsert,noselect",
        },
        window = {
          documentation = {
            border = "none",
            winhighlight = "Normal:NormalFloat",
          },
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ["<C-d>"] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Select,
            count = 4,
          }),
          ["<C-u>"] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Select,
            count = 4,
          }),
          ["<C-k>"] = cmp.mapping.scroll_docs(-4),
          ["<C-j>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<Down>"] = cmp.mapping(function(fallback)
            cmp.close()
            fallback()
          end, { "i" }),
          ["<Up>"] = cmp.mapping(function(fallback)
            cmp.close()
            fallback()
          end, { "i" }),
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
        formatting = {
          format = function(_, item)
            local icons = require("lazyvim.config").icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind]
            end
            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        sorting = defaults.sorting,
      }
    end,
    ---@param opts cmp.ConfigSchema
    config = function(_, opts)
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end
      require("cmp").setup(opts)
    end,
  },
}
