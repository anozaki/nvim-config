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
		},
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
	},
}
