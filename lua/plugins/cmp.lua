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
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local types = require("cmp.types")

      opts.preselect = types.cmp.PreselectMode.None
      opts.completion = {
        completeopt = "menu,menuone,noinsert,noselect",
      }
      opts.window = {
        documentation = {
          border = "none",
          winhighlight = "Normal:CmpDocNormalFloat",
        },
      }
      opts.mapping = cmp.mapping.preset.insert({
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
      })
      opts.sources = cmp.config.sources({
        {
          name = "nvim_lsp",
          group_index = 1,
          priority = 100,
        },
        {
          name = "copilot",
          group_index = 1,
          priority = 100,
        },
        {
          name = "path",
          group_index = 2,
          priority = 90,
        },
      }, {
        { name = "buffer" },
      })
      opts.formatting = {
        format = function(_, item)
          local icons = require("lazyvim.config").icons.kinds
          if icons[item.kind] then
            item.kind = icons[item.kind]
          end
          return item
        end,
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
      },
    },
  },
}
