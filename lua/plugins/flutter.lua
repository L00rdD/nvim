return {
  "akinsho/flutter-tools.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim",
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
          device = false, -- ❗ important → ne pas forcer un device global
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
          enabled = true,
          background = false,
          foreground = false,
          virtual_text = true,
          virtual_text_str = "■",
        },
        capabilities = function(config)
          config.specificThingIDontWant = false
          return config
        end,
        -- PAS de root_patterns ici
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          renameFilesWithClasses = "prompt",
          updateImportsOnRename = true,
        },
      },
    })

    -- Reste de tes mappings identiques…
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "__FLUTTER_DEV_LOG__",
      callback = function()
        vim.bo.buflisted = true
        vim.bo.bufhidden = ""
      end,
    })

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

    vim.keymap.set("n", "<leader><CR>", function()
      vim.lsp.buf.code_action()
    end, { desc = "Flutter LSP code actions" })

    local function get_flutter_cmd()
      if vim.fn.executable("fvm") == 1 then
        return "fvm flutter test "
      else
        return "flutter test "
      end
    end

    local function open_temp_terminal(cmd)
      local height = math.floor(vim.o.lines * 0.25)
      vim.cmd(height .. "split")
      vim.cmd("te " .. cmd)
      vim.cmd("startinsert")
    end

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
  end,
}
