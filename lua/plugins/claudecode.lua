return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" }, -- terminal intégré
  cmd = {
    "ClaudeCode",
    "ClaudeCodeFocus",
    "ClaudeCodeAdd",
    "ClaudeCodeSend",
    "ClaudeCodeTreeAdd",
    "ClaudeCodeDiffAccept",
    "ClaudeCodeDiffDeny",
    "ClaudeCodeSelectModel",
  },
  -- <leader>aa/ax/aq/ap = CopilotChat, <leader>ac/au/am = Arduino, <leader>ai = LSP :
  -- les raccourcis ci-dessous évitent ces touches.
  keys = {
    { "<leader>at", "<cmd>ClaudeCode<cr>", desc = "Afficher/Masquer Claude" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus sur Claude" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Reprendre une session Claude" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continuer la dernière session Claude" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Ajouter le buffer courant à Claude" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Envoyer la sélection à Claude" },
    {
      "<leader>as",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Ajouter le fichier à Claude",
      ft = { "neo-tree" },
    },
    { "<leader>ay", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accepter le diff de Claude" },
    { "<leader>an", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Refuser le diff de Claude" },
  },
  opts = {},
}
