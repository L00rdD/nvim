return {
  "akinsho/flutter-tools.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim", -- optional for vim.ui.select
  },
  config = function()
    local flutterConfig = require("flutter-tools")

    flutterConfig.setup({
      ui = {
        border = "rounded",
        notification_style = "native",
      },
      decorations = {
        statusline = {
          app_version = true,
          device = true,
          project_config = true,
        },
      },
      debugger = {
        enabled = false,
        run_via_dap = false,
        exception_breakpoints = {},
      },
      root_patterns = { ".git", "pubspec.yaml" },
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
        open_cmd = "tabedit",
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
        color = {
          enabled = false,
          background = false,
          foreground = false,
          virtual_text = true,
          virtual_text_str = "■",
        },
        capabilities = function(config)
          config.specificThingIDontWant = false
          return config
        end,
        analysisExcludedFolders = { "./fvm/" },
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          renameFilesWithClasses = "prompt",
          updateImportsOnRename = true,
        },
      },
    })

    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "__FLUTTER_DEV_LOG__",
      callback = function()
        vim.bo.buflisted = true
        vim.bo.bufhidden = ""
      end,
    })

    -- [[ Configure Flutter tools ]]
    vim.keymap.set(
      "n",
      "<leader>1",
      require("telescope").extensions.flutter.commands,
      { desc = "Open Flutter commands" }
    )

    -- Build runner (ancienne version conservée sous b1)
    vim.keymap.set("n", "<leader>b1", function()
      vim.cmd("20new")
      vim.cmd("te fvm flutter packages pub run build_runner build --delete-conflicting-outputs")
      vim.cmd("2sleep | normal G")
    end, { desc = "Run build_runner (legacy)" })

    -- Code actions
    vim.keymap.set("n", "<leader><CR>", function()
      vim.lsp.buf.code_action()
    end, { desc = "Flutter LSP code actions" })

    -- 🔧 Utilitaire : récupère la commande flutter (fvm ou non)
    local function get_flutter_cmd()
      if vim.fn.executable("fvm") == 1 then
        return "fvm flutter test "
      else
        return "flutter test "
      end
    end

    -- 🔧 Fonction réutilisable : ouvre un terminal éphémère (25% split)
    local function open_temp_terminal(cmd)
      local height = math.floor(vim.o.lines * 0.25)
      vim.cmd(height .. "split")
      vim.cmd("te " .. cmd)

      -- Ferme automatiquement la fenêtre et le buffer à la fin du job
      vim.api.nvim_create_autocmd("TermClose", {
        buffer = 0,
        once = true,
        callback = function(event)
          local win = vim.fn.bufwinid(event.buf)
          if win ~= -1 then
            vim.api.nvim_win_close(win, true)
          end
          if vim.api.nvim_buf_is_valid(event.buf) then
            vim.api.nvim_buf_delete(event.buf, { force = true })
          end
        end,
      })
    end

    -- ▶️ Test du fichier courant
    vim.keymap.set("n", "<leader>2t", function()
      open_temp_terminal(get_flutter_cmd() .. vim.fn.expand("%"))
    end, { desc = "Test current file (25% split)" })

    -- ▶️ Test de tous les fichiers
    vim.keymap.set("n", "<leader>2T", function()
      open_temp_terminal(get_flutter_cmd())
    end, { desc = "Test all files (25% split)" })

    -- 🏗️ Build Runner
    vim.keymap.set("n", "<leader>2d", function()
      open_temp_terminal("dart run build_runner build --delete-conflicting-outputs")
    end, { desc = "Run build_runner (25% split)" })
  end,
}
