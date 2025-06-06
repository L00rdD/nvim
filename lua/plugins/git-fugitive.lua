-- git-fugitive.lua

-- Assurez-vous que lazy.nvim est bien installé avant de charger ce plugin
return {
  "tpope/vim-fugitive", -- Plugin Git Fugitive
  config = function()
    -- Configuration pour Git Fugitive
    vim.api.nvim_set_keymap("n", "<leader>gss", ":Git status<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>gcc", ":Git commit<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>gpp", ":Git push<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>gll", ":Git log<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>gff", ":Git fetch<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>gdd", ":Git diff<CR>", { noremap = true, silent = true })

    -- Utilisation de Fugitive pour résoudre les conflits
    vim.api.nvim_set_keymap("n", "<leader>gdc", ":Gdiffsplit<CR>", { noremap = true, silent = true }) -- Diff et résolution de conflits
    vim.api.nvim_set_keymap("n", "<leader>gww", ":Gwrite<CR>", { noremap = true, silent = true }) -- Sauvegarde des changements dans un fichier
    vim.api.nvim_set_keymap("n", "<leader>grr", ":Gread<CR>", { noremap = true, silent = true }) -- Récupération du fichier original en cas de conflit
  end,
}
