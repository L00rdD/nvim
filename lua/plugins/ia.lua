return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
  },
  opts = {
      adapters = {
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            env = {
              api_key = "GEMINI_API_KEY",
            },
          })
        end,
      },
      strategies = {
        chat = { 
          adapter = {
            name = "gemini", model = "gemini-2.5-flash", 
          }, 
        },
        inline = { 
          adapter = {
            name = "gemini", model = "gemini-2.5-flash", 
          }, 
        },
        agent = { 
          adapter = {
            name = "gemini", model = "gemini-2.5-flash", 
          }, 
        },
      },
  }
}
