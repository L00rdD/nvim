return {
  -- Plugins à installer
  {
    "hrsh7th/cmp-nvim-lsp",
    event = "InsertEnter", -- Le plugin se charge lorsque tu entres en mode Insertion
    dependencies = {
      "hrsh7th/nvim-cmp", -- Complétion générale
      "hrsh7th/cmp-buffer", -- Complétion depuis le buffer
      "saadparwaiz1/cmp_luasnip", -- Complétion avec LuaSnip
    },
    config = function()
      local cmp = require("cmp")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Configuration de cmp
      cmp.setup({
        completion = {
          completeopt = "menu,menuone,noinsert", -- Définit l'option de complétion
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- Complétion provenant du LSP
          { name = "luasnip" }, -- Complétion provenant de LuaSnip
        }, {
          { name = "buffer" }, -- Complétion provenant du buffer actuel
        }),
      })
    end,
  },
}
