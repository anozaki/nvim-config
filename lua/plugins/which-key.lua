return {
	{
		"folke/which-key.nvim",
		lazy = false,
		config = function()
			local wk = require("which-key")
			wk.setup({})

			wk.register({
				t = { name = "Test" },
				g = { name = "Git" },
				h = { name = "Hunk" },
				d = {
					name = "Debug",
					t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
					b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
					c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
					C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
					d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
					g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
					i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
					o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
					u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
					p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
					r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
					s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
					q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
					U = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle UI" },
				},
				f = {
					name = "Find",
					b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
					c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
					f = { "<cmd>Telescope find_files<cr>", "Find File" },
					h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
					H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
					M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
					r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
					R = { "<cmd>Telescope registers<cr>", "Registers" },
					t = { "<cmd>Telescope live_grep<cr>", "Text" },
					k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
					C = { "<cmd>Telescope commands<cr>", "Commands" },
					l = { "<cmd>Telescope resume<cr>", "Resume last search" },
				},
				l = { name = "LSP" },
			}, { prefix = "<leader>" })
		end,
	},
}
