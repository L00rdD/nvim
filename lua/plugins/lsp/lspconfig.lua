return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    -- Import des plugins
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local keymap = vim.keymap -- Pour raccourcis

    -- Configuration générale pour l'auto-importation
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Configuration de clangd pour C++/Qt
    lspconfig.clangd.setup({
      cmd = { "clangd" },
      root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
      filetypes = { "c", "cpp", "objc", "objcpp" },
      single_file_support = true,
      capabilities = capabilities,
    })

    -- Configuration du serveur Dart pour Flutter
    lspconfig.dartls.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, silent = true }
        keymap.set("n", "<leader>ai", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts) -- Action pour auto-import
      end,
      settings = {
        dart = {
          completeFunctionCalls = true,
          enableFlutterOutline = true,
          showTodos = true,
          autoImport = {
            enabled = true, -- Activer l'auto-importation
          },
        },
        flutter = {
          completeFunctionCalls = true,
        },
      },
    })

    -- Configuration pour TypeScript (auto-importation)
    lspconfig.tsserver.setup({
      capabilities = capabilities,
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

    -- Autres configurations LSP...
  end,
}
