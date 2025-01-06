return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspconfig = require("lspconfig")

    require("luasnip.loaders.from_vscode").lazy_load()

    -- L'activation des capacités pour l'auto-importation
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Configuration de cmp
    cmp.setup({
      completion = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
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

    -- Configuration du serveur LSP (ici tsserver pour l'auto-importation)
    lspconfig.tsserver.setup({
      capabilities = capabilities, -- Ceci active l'auto-importation
      settings = {
        javascript = {
          format = { enable = true },
          autoImportSuggestions = true, -- Active l'auto-importation pour JS
        },
        typescript = {
          format = { enable = true },
          autoImportSuggestions = true, -- Active l'auto-importation pour TS
        },
      },
    })
  end,
}
