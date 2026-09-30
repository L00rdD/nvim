return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",     -- Source LSP
      "hrsh7th/cmp-buffer",       -- Source Buffer
      "saadparwaiz1/cmp_luasnip", -- Source Snippets
      "L3MON4D3/LuaSnip",         -- Moteur de snippets (requis pour cmp_luasnip)
    },
    config = function()
      local cmp = require("cmp")
      -- On s'assure que luasnip est présent pour éviter d'autres erreurs
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = "menu,menuone,preview,noselect",
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(), -- Navigation haut
          ["<C-j>"] = cmp.mapping.select_next_item(), -- Navigation bas
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
}
