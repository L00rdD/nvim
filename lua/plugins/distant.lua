-- Configuration for distant.nvim with the specific binary path
return {
  'chipsenkbeil/distant.nvim',
  branch = 'v0.3',
  config = function()
    require('distant'):setup({
      -- Use the absolute path discovered by the find command
      bin = "/Users/d/.local/share/nvim/distant.nvim/bin/distant"
    })
  end
}
