return {
  {
    "codethread/qmk.nvim",
    ft = { "dts", "keymap" }, -- se charge uniquement sur les fichiers ZMK/QMK
    config = function()
      require("qmk").setup({
        name = "LAYOUT_sofle",
        layout = {
          "x x x x x x _ x x x x x x",
          "x x x x x x _ x x x x x x",
          "x x x x x x _ x x x x x x",
          "x x x x x x _ x x x x x x",
          "_ _ _ x x x _ x x x _ _ _", -- rangée des pouces du Sofle
        },
        auto_format_pattern = "sofle%.keymap$", -- active QMKFormat automatiquement pour ce fichier
      })

      -- (optionnel) : format auto à la sauvegarde
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.keymap",
        callback = function()
          vim.cmd("QMKFormat")
        end,
      })
    end,
  },
}
