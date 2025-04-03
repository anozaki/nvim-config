return {
  {
    "jackMort/ChatGPT.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = {
      api_key_cmd = 'op read "op://Personal/OpenAI API Key/api key"',
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
}
