return {
  "akinsho/flutter-tools.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim",
  },
  config = function()
    local flutterConfig = require("flutter-tools")
    local flutter_format_group = vim.api.nvim_create_augroup("FlutterLspFormatting", {})

    -- LSP capabilities (cmp)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok, cmp = pcall(require, "cmp_nvim_lsp")
    if ok then
      capabilities = cmp.default_capabilities(capabilities)
    end

    -- Common on_attach (Flutter only)
    local function on_attach(client, bufnr)
      local opts = { buffer = bufnr, silent = true }

      -- VS Code-like navigation
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
      vim.keymap.set("n", "K",  vim.lsp.buf.hover, opts)

      -- Code actions
      vim.keymap.set("n", "<leader><CR>", vim.lsp.buf.code_action, opts)

      if client.name == "dartls" then
        -- Manual Dart format
        vim.keymap.set("n", "<leader>5", function()
          local file = vim.api.nvim_buf_get_name(0)
          if file == "" then
            return
          end

          local cmd
          if vim.fn.executable("fvm") == 1 then
            cmd = { "fvm", "dart", "format", file }
          else
            cmd = { "dart", "format", file }
          end

          vim.fn.system(cmd)
          vim.cmd("checktime")
        end, { buffer = bufnr, desc = "Format Dart (dart format)" })

        -- Format Dart ON SAVE
        local group = vim.api.nvim_create_augroup(
          "FlutterDartFormatOnSave",
          { clear = false }
        )

        vim.api.nvim_clear_autocmds({
          group = group,
          buffer = bufnr,
        })
      end
    end

    flutterConfig.setup({
      ui = {
        border = "rounded",
        notification_style = "native",
      },
      decorations = {
        statusline = {
          app_version = true,
          device = false,
          project_config = true,
        },
      },
      debugger = { enabled = false, run_via_dap = false },
      fvm = true,
      widget_guides = { enabled = false },
      closing_tags = {
        highlight = "Comment",
        prefix = "//",
        enabled = true,
      },
      dev_log = {
        enabled = true,
        notify_errors = false,
        -- Ouverture des logs en split horizontal en bas (15 lignes de haut)
        open_cmd = "botright 15split", 
      },
      dev_tools = {
        autostart = false,
        auto_open_browser = false,
      },
      outline = {
        open_cmd = "30vnew",
        auto_open = false,
      },
      lsp = {
        capabilities = capabilities,
        on_attach = on_attach,
        color = {
          enabled = true,
          background = false,
          foreground = false,
          virtual_text = true,
          virtual_text_str = "■",
        },
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          renameFilesWithClasses = "prompt",
          updateImportsOnRename = true,
        },
      },
    })

    -- Autocmd pour s'assurer que le buffer de log s'affiche correctement
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "__FLUTTER_DEV_LOG__",
      callback = function()
        vim.bo.buflisted = true
        vim.bo.bufhidden = ""
      end,
    })

    -- Flutter and build_runner mappings
    vim.keymap.set(
      "n",
      "<leader>1",
      require("telescope").extensions.flutter.commands,
      { desc = "Open Flutter commands" }
    )

    vim.keymap.set("n", "<leader>b1", function()
      vim.cmd("20new")
      vim.cmd("te fvm flutter packages pub run build_runner build --delete-conflicting-outputs")
      vim.cmd("2sleep | normal G")
    end, { desc = "Run build_runner (legacy)" })

    local function get_flutter_cmd()
      if vim.fn.executable("fvm") == 1 then
        return "fvm flutter test --reporter=failures-only "
      else
        return "flutter test --reporter=failures-only "
      end
    end

    local function open_temp_terminal(cmd)
      local height = math.floor(vim.o.lines * 0.25)
      vim.cmd(height .. "split")
      vim.cmd("te " .. cmd)
      vim.cmd("startinsert")
    end

    -- Testing and pub mappings
    vim.keymap.set("n", "<leader>2t", function()
      open_temp_terminal(get_flutter_cmd() .. vim.fn.expand("%"))
    end, { desc = "Test current file" })

    vim.keymap.set("n", "<leader>2T", function()
      open_temp_terminal(get_flutter_cmd())
    end, { desc = "Test all files" })

    vim.keymap.set("n", "<leader>2d", function()
      open_temp_terminal("dart run build_runner build --delete-conflicting-outputs")
    end, { desc = "Run build_runner" })

    vim.keymap.set("n", "<leader>2g", function()
      open_temp_terminal("flutter pub get")
    end, { desc = "pub get" })

    -- Échap pour quitter le mode insertion du terminal
    vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
  end,
}
