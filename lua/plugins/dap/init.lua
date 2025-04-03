return {
	{
		"mfussenegger/nvim-dap",
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		config = function()
			require("dap-python").setup("python")
		end,
		dependencies = {
			"mfussenegger/nvim-dap",
		},
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup({})
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
		keys = function()
			local dapui = require("dapui")
			return {
				{
					"<leader>dU",
					function()
						dapui.toggle()
					end,
					desc = "DAP UI",
				},
			}
		end,
	},
	{ "nvim-neotest/nvim-nio" },
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-python",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-python")({
						dap = {
							justMyCode = false,
							console = "integratedTerminal",
						},
						args = { "--log-level", "DEBUG", "--quiet" },
						runner = "pytest",
					}),
				},
			})
		end,
		keys = function()
			neo = require("neotest")
			return {
				{
					"<leader>tm",
					function()
						neo.run.run()
					end,
					desc = "Test Method",
				},
				{
					"<leader>tM",
					function()
						neo.run.run({ strategy = "dap" })
					end,
					desc = "Test Method (Debug)",
				},
				{
					"<leader>tf",
					function()
						neo.run.run({ vim.fn.expand("%") })
					end,
					desc = "Test Class",
				},
				{
					"<leader>tF",
					function()
						neo.run.run({ vim.fn.expand("%"), strategy = "dap" })
					end,
					desc = "Test Method (Debug)",
				},
				{
					"<leader>ts",
					function()
						neo.summary.toggle()
					end,
					desc = "Test Method",
				},
				{
					"<leader>tl",
					function()
						neo.run.last()
					end,
					desc = "Run Last Test",
				},
			}
		end,
	},
	{
		"nvim-neotest/neotest-python",
		dependencies = {
			"nvim-neotest/neotest",
		},
		config = false,
	},
}
