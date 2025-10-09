-- bootstrap lazy.nvim, LazyVim and your plugins
vim.keymap.set("x", "p", '"_dP', { silent = true })
require("config.lazy")
