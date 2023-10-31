return {
  {
    "windwp/nvim-autopairs",
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
    },
    config = true,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua", "python", "rust"
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
        ident = {
          enable = true
        }
      }
    }
  }
}


