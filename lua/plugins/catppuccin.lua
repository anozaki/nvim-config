
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = { flavor = "macchiato" },
    config = function()
      vim.cmd.colorscheme "catppuccin"
    end,
  }
}
