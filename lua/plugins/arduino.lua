return {
  "folke/which-key.nvim", -- Facultatif mais recommandé pour afficher les raccourcis
  config = function()
    vim.api.nvim_create_user_command("ArduinoCompile", function()
      vim.cmd("write") -- sauve le fichier en cours
      vim.cmd("!arduino-cli compile --fqbn arduino:avr:uno .")
    end, {})

    vim.api.nvim_create_user_command("ArduinoUpload", function()
      vim.cmd("write")
      vim.cmd("!arduino-cli upload -p /dev/ttyUSB0 --fqbn arduino:avr:uno .")
    end, {})

    vim.api.nvim_create_user_command("ArduinoMonitor", function()
      vim.cmd("!arduino-cli monitor -p /dev/ttyUSB0 -c baudrate=9600")
    end, {})

    -- Mappings (à adapter selon ton setup clavier)
    vim.keymap.set("n", "<leader>ac", ":ArduinoCompile<CR>", { desc = "Arduino: Compile" })
    vim.keymap.set("n", "<leader>au", ":ArduinoUpload<CR>", { desc = "Arduino: Upload" })
    vim.keymap.set("n", "<leader>am", ":ArduinoMonitor<CR>", { desc = "Arduino: Monitor" })
  end,
}
