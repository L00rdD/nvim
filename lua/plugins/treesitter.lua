return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" }, -- Charge le plugin uniquement quand on ouvre un fichier
    config = function()
      -- On utilise pcall (protected call) pour éviter de faire crash Neovim 
      -- si le module est vraiment introuvable
      local status_ok, configs = pcall(require, "nvim-treesitter.configs")
      if not status_ok then
        return
      end

      configs.setup({
        -- Langages à installer automatiquement
        ensure_installed = { 
          "lua", 
          "vim", 
          "vimdoc", 
          "query", 
          "markdown", 
          "markdown_inline",
          "dart" -- Très important pour ton projet Flutter !
        },
        sync_install = false,
        highlight = {
          enable = true, -- Active la coloration syntaxique Treesitter
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end,
  },
}
