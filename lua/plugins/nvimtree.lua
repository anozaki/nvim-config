return {
	{
		"nvim-tree/nvim-tree.lua",
		opts = {
			filters = {
				dotfiles = false,
				git_ignored = false,
			},
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")
				api.config.mappings.default_on_attach(bufnr)
			end,
		},
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Open Tree" },
			{ "<leader>E", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Tree at current file" },
		},
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
	},
}
