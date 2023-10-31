return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files"},
      { "<leader>fs", "<cmd>Telescope find_git_files<cr>", desc = "Find Git Files"},
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep"},
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffer"},
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Help Tags"},
    },
    dependencies = { 
      "nvim-lua/plenary.nvim", 
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
  }
}
