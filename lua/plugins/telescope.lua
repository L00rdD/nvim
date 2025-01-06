--telescope.lua
return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        -- Autres configurations par défaut
        file_ignore_patterns = {}, -- Vide cette liste pour ne pas ignorer de fichiers
      },
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--no-ignore" }, -- Utilise ripgrep sans tenir compte des fichiers ignorés
        },
      },
    })
  end,
}
