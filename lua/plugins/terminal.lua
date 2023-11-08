return {
  {
    "akinsho/toggleterm.nvim",
    lazy = false,
    opts = {
      open_mapping = [[<m-1>]],
    },
    keys = {
      { [[<esc>]], [[<c-\><c-n>]], mode = "t", "Esc Terminal" },
      { [[<c-h>]], [[<cmd>wincmd h<cr>]], mode="t"},
      { [[<c-j>]], [[<cmd>wincmd j<cr>]], mode="t"},
      { [[<c-k>]], [[<cmd>wincmd k<cr>]], mode="t"},
      { [[<c-l>]], [[<cmd>wincmd l<cr>]], mode="t"},
    },
  },
}
