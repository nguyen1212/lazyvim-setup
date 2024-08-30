return {
  -- completion
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    event = "LspAttach",
    opts = function(_, opts)
      local cmp = require("cmp")
      local types = require("cmp.types")
      -- local compare = require("cmp.config.compare")

      ---@type table<integer, integer>
      local modified_priority = {
        -- [types.lsp.CompletionItemKind.Variable] = 0,
        -- [types.lsp.CompletionItemKind.Function] = types.lsp.CompletionItemKind.Function,
        -- [types.lsp.CompletionItemKind.Keyword] = 10, -- top
        -- [types.lsp.CompletionItemKind.Snippet] = 100, -- bottom
        -- [types.lsp.CompletionItemKind.Text] = 100, -- bottom
      }
      ---@param kind integer: kind of completion entry
      local function modified_kind(kind)
        return modified_priority[kind] or kind
      end

      opts = opts or {}

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

      -- opts.sorting = {
      --   -- https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/compare.lua
      --   comparators = {
      --     compare.offset,
      --     compare.exact,
      --     function(entry1, entry2) -- sort by length ignoring "=~"
      --       local len1 = string.len(string.gsub(entry1.completion_item.label, "[=~()_]", ""))
      --       local len2 = string.len(string.gsub(entry2.completion_item.label, "[=~()_]", ""))
      --       if len1 ~= len2 then
      --         return len1 - len2 < 0
      --       end
      --     end,
      --     compare.recently_used,
      --     function(entry1, entry2) -- sort by compare kind (Variable, Function etc)
      --       local kind1 = modified_kind(entry1:get_kind())
      --       local kind2 = modified_kind(entry2:get_kind())
      --       if kind1 ~= kind2 then
      --         return kind1 - kind2 < 0
      --       end
      --     end,
      --     function(entry1, entry2) -- score by lsp, if available
      --       local t1 = entry1.completion_item.sortText
      --       local t2 = entry2.completion_item.sortText
      --       if t1 ~= nil and t2 ~= nil and t1 ~= t2 then
      --         return t1 < t2
      --       end
      --     end,
      --     compare.score,
      --     compare.order,
      --   },
      -- }
    end,
  },
  {
    "garymjr/nvim-snippets",
    enabled = false,
  },
  {
    "rafamadriz/friendly-snippets",
    enabled = false,
  },
  {
    "echasnovski/mini.completion",
    version = "*",
    enabled = false,
    config = function(_, opts)
      opts = opts or {}
      opts.lsp_completion = opts.lsp_completion or {}
      opts.lsp_completion.source_func = "omnifunc"
      require("mini.completion").setup(opts)
    end,
    -- init = function()
    --   au.on_lsp_attach(function(_, bufnr)
    --     vim.api.nvim_set_option_value("omnifunc", "v:lua.MiniCompletion.completefunc_lsp", {
    --       buf = bufnr,
    --     })
    --   end)
    -- end,
  },
  {
    "saghen/blink.cmp",
    enabled = false,
  },
}
