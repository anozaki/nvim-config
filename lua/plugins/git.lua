BoldLineLeft = "▎"
Triangle = "󰐊"

return {
	{
		"kdheepak/lazygit.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		opts = {
			signs = {
				add = { text = BoldLineLeft },
				change = { text = BoldLineLeft },
				delete = { text = Triangle },
				topdelete = { text = Triangle },
				changedelete = { text = BoldLineLeft },
			},
			signcolumn = true,
			numhl = false,
			linehl = false,
			word_diff = false,
			watch_gitdir = {
				interval = 1000,
				follow_files = true,
			},
			attach_to_untracked = true,
			current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = false,
			},
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
			sign_priority = 6,
			status_formatter = nil, -- Use default
			update_debounce = 200,
			max_file_length = 40000,
			preview_config = {
				-- Options passed to nvim_open_win
				border = "rounded",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
		},
		keys = function()
			local gs = require("gitsigns")
			return {
				{ "<leader>hr", gs.reset_hunk, desc = "Reset Hunk" },
				{
					"<leader>hr",
					function()
						gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end,
					mode = "v",
					desc = "Reset Hunk",
				},
				{ "<leader>hR", gs.reset_buffer, desc = "Reset Buffer" },
				{ "<leader>hp", gs.preview_hunk, desc = "Preview Hunk" },
				{ "<leader>tb", gs.toggle_current_line_blame, desc = "Toggle Blame" },
			}
		end,
	},
}
