return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup({
      -- Active le blame permanent de la ligne courante
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 300, -- délai avant l’apparition du texte
        virt_text_pos = "eol", -- position du texte : "eol" = fin de ligne
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",

      -- Signes de modification dans la marge
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    })

    -- Raccourcis
    vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>", { desc = "Afficher l'auteur de la ligne (popup)" })
    vim.keymap.set(
      "n",
      "<leader>gB",
      ":Gitsigns toggle_current_line_blame<CR>",
      { desc = "Activer/Désactiver blame permanent" }
    )
  end,
}
