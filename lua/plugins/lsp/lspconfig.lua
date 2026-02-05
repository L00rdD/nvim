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

    -- ✅ on_attach GÉNÉRIQUE (SANS FORMAT)
    local function on_attach(client, bufnr)
      local opts = { buffer = bufnr, silent = true }

      keymap.set("n", "<leader>ai", vim.lsp.buf.code_action, opts)
      keymap.set("n", "<leader>5", function()
        vim.lsp.buf.format({ async = true })
      end, { desc = "Format file via LSP" })

      -- ❌ tsserver ne doit JAMAIS formatter
      if client.name == "tsserver" then
        client.server_capabilities.documentFormattingProvider = false
      end
    end

    -- C / C++
    lspconfig.clangd.setup({
      cmd = { "clangd" },
      root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
      filetypes = { "c", "cpp", "objc", "objcpp" },
      single_file_support = true,
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- TypeScript / JavaScript
    lspconfig.tsserver.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- Kotlin
    lspconfig.kotlin_language_server.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      root_dir = lspconfig.util.root_pattern(
        "settings.gradle",
        "build.gradle",
        ".git"
      ),
    })
  end,
}
