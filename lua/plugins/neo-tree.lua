return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "main", -- Assurez-vous d'utiliser la dernière version de Neo-tree
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- Dépendances nécessaires
    "MunifTanjim/nui.nvim", -- Optionnel pour les fenêtres modales
  },
  config = function()
    require("neo-tree").setup({
      filesystem = {
        commands = {
          move = function(state)
            local node = state.tree:get_node()
            local src_path = node.path
            local root_dir = vim.fn.getcwd() -- Récupère le répertoire de travail actuel (racine du projet)

            -- Convertit le chemin source en chemin relatif
            local relative_src_path = vim.fn.fnamemodify(src_path, ":p") -- Conserve le chemin absolu
            relative_src_path = vim.fn.fnamemodify(relative_src_path, ":~") -- Utilise ~ pour obtenir un chemin relatif à partir de root_dir

            -- Affiche le chemin relatif dans la commande de déplacement
            local dest_path = vim.fn.input("Move to: ", relative_src_path, "file")

            -- Exécute la commande mv avec les chemins relatifs
            local full_dest_path = root_dir .. "/" .. dest_path
            vim.fn.system({ "mv", src_path, full_dest_path })

            -- Rafraîchit Neo-tree après déplacement
            require("neo-tree.sources.filesystem").refresh()
          end,
        },
        window = {
          mappings = {
            m = "move", -- Associe la touche m à la commande move
          },
        },
      },
      window = {
        position = "left", -- Positionne Neo-tree sur le côté gauche
        width = 40, -- Largeur de la fenêtre
      },
      default_component_configs = {
        name = {
          highlight = "NeoTreeFileName", -- Applique un style de surbrillance aux noms de fichiers
        },
      },
    })

    vim.keymap.set(
      "n",
      "<leader>fi",
      ":Neotree reveal<CR>",
      { noremap = true, silent = true, desc = "Reveal file in Neotree" }
    )
  end,
}
