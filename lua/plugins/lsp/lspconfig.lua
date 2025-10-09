return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local keymap = vim.keymap

    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Fonction commune pour activer format on save
    local function on_attach(client, bufnr)
      -- Format on save
      if client.server_capabilities.documentFormattingProvider then
        local group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = group,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
          end,
        })
      end

      local opts = { buffer = bufnr, silent = true }
      keymap.set("n", "<leader>ai", vim.lsp.buf.code_action, opts)
      keymap.set("n", "<leader>5", function()
        vim.lsp.buf.format({ async = true })
      end, { desc = "Format file via LSP" })
    end

    -- clangd pour C/C++
    lspconfig.clangd.setup({
      cmd = { "clangd" },
      root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
      filetypes = { "c", "cpp", "objc", "objcpp" },
      single_file_support = true,
      capabilities = capabilities,
      on_attach = on_attach, -- <- important
    })

    -- dartls pour Flutter/Dart
    lspconfig.dartls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        dart = {
          completeFunctionCalls = true,
          enableFlutterOutline = true,
          showTodos = true,
          autoImport = {
            enabled = true,
          },
        },
        flutter = {
          completeFunctionCalls = true,
        },
      },
    })

    -- tsserver pour TypeScript/JS
    lspconfig.tsserver.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        javascript = {
          format = { enable = true },
          autoImportSuggestions = true,
        },
        typescript = {
          format = { enable = true },
          autoImportSuggestions = true,
        },
      },
    })

    -- kotlin-language-server
    lspconfig.kotlin_language_server.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      root_dir = lspconfig.util.root_pattern("settings.gradle", "build.gradle", ".git"),
    })
  end,
}
