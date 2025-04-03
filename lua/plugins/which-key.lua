return {
  { "echasnovski/mini.icons", version = false },
  {
    "folke/which-key.nvim",
    lazy = false,
    config = function()
      local wk = require("which-key")
      wk.add({
        { "<leader>d",  group = "Debug" },
        { "<leader>dC", "<cmd>lua require'dap'.run_to_cursor()<cr>",          desc = "Run To Cursor" },
        { "<leader>dU", "<cmd>lua require'dapui'.toggle({reset = true})<cr>", desc = "Toggle UI" },
        { "<leader>db", "<cmd>lua require'dap'.step_back()<cr>",              desc = "Step Back" },
        { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>",               desc = "Continue" },
        { "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>",             desc = "Disconnect" },
        { "<leader>dg", "<cmd>lua require'dap'.session()<cr>",                desc = "Get Session" },
        { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>",              desc = "Step Into" },
        { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>",              desc = "Step Over" },
        { "<leader>dp", "<cmd>lua require'dap'.pause()<cr>",                  desc = "Pause" },
        { "<leader>dq", "<cmd>lua require'dap'.close()<cr>",                  desc = "Quit" },
        { "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>",            desc = "Toggle Repl" },
        { "<leader>ds", "<cmd>lua require'dap'.continue()<cr>",               desc = "Start" },
        { "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>",      desc = "Toggle Breakpoint" },
        { "<leader>du", "<cmd>lua require'dap'.step_out()<cr>",               desc = "Step Out" },
        { "<leader>f",  group = "Find" },
        { "<leader>fC", "<cmd>Telescope commands<cr>",                        desc = "Commands" },
        { "<leader>fH", "<cmd>Telescope highlights<cr>",                      desc = "Find highlight groups" },
        { "<leader>fM", "<cmd>Telescope man_pages<cr>",                       desc = "Man Pages" },
        { "<leader>fR", "<cmd>Telescope registers<cr>",                       desc = "Registers" },
        { "<leader>fb", "<cmd>Telescope git_branches<cr>",                    desc = "Checkout branch" },
        { "<leader>fc", "<cmd>Telescope colorscheme<cr>",                     desc = "Colorscheme" },
        { "<leader>ff", "<cmd>Telescope find_files<cr>",                      desc = "Find File" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>",                       desc = "Find Help" },
        { "<leader>fk", "<cmd>Telescope keymaps<cr>",                         desc = "Keymaps" },
        { "<leader>fl", "<cmd>Telescope resume<cr>",                          desc = "Resume last search" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                        desc = "Open Recent File" },
        { "<leader>ft", "<cmd>Telescope live_grep<cr>",                       desc = "Text" },
        { "<leader>g",  group = "Git" },
        { "<leader>h",  group = "Hunk" },
        { "<leader>l",  group = "LSP" },
        { "<leader>t",  group = "Test" },
      })
    end,
  },
}
