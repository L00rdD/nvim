return {
  -- Générateur de commentaires Doxygen
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
    opts = {
      snippet_engine = "luasnip",
      languages = {
        cpp = { template = { annotation_convention = "doxygen" } },
        c = { template = { annotation_convention = "doxygen" } },
      },
    },
    keys = {
      { "<leader>cd", "<cmd>lua require('neogen').generate()<CR>", desc = "Générer la documentation Doxygen" },
    },
  },

  -- Interface CMake pour compiler et générer le compile_commands.json
  {
    "Civitasv/cmake-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      cmake_command = "cmake",
      cmake_build_directory = "build",
      -- Indispensable pour que clangd comprenne ton projet
      cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
    },
    keys = {
      { "<leader>cg", "<cmd>CMakeGenerate<CR>", desc = "Générer le projet CMake" },
      { "<leader>cb", "<cmd>CMakeBuild<CR>", desc = "Compiler le projet CMake" },
      { "<leader>cr", "<cmd>CMakeRun<CR>", desc = "Exécuter la cible" },
      { "<leader>ct", "<cmd>CMakeRunTest<CR>", desc = "Lancer les tests GTest" },
    },
  },
}
