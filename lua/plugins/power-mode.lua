return {
  "axsaucedo/neovim-power-mode",
  config = function()
    require("power-mode").setup({
      particles = { preset = "emoji" },
      shake = { mode = "none" },
       backspace = {
        enabled = true,            -- Enable fire particles on backspace
        preset = "fire",           -- Preset for backspace effect
      },
       fire_wall = {
        enabled = true,      
      },
    })
  end,
}
