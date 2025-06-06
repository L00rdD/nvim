return {
  {
    "samoshkin/vim-mergetool",
    cmd = { "MergetoolStart", "MergetoolStop" },
    config = function()
      -- Paramétrage de vim-mergetool
      vim.g.mergetool_layout = "mr" -- Affiche la version MERGED à droite
      vim.g.mergetool_prefer_revision = "local" -- Préférer les changements locaux par défaut
      vim.g.mergetool_hide_processed = 1 -- Cache les parties déjà résolues
      vim.g.mergetool_show_base = 1 -- Afficher la fenêtre BASE
    end,
  },
}
