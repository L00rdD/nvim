return {
  "tiagovla/scope.nvim",
  -- This plugin isolates buffers to their respective tabs
  config = function()
    require("scope").setup()
  end,
}
