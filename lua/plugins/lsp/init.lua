local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local set_diagnostic_icon = function()
	local signs = {
		Error = " ",
		Warn = "⚠ ",
		Hint = " ",
		Info = " ",
	}

	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end
end

local common_on_attach = function(_client, bufnr)
	vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Goto Definition" })
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Goto Declaration" })
	vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "References" })
	vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Goto Type Definition" })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Goto implementation" })
	vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature Help" })
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover [LSP]" })
	vim.keymap.set("n", "gl", vim.diagnostic.open_float, { buffer = bufnr, desc = "Line Info" })

	set_diagnostic_icon()
end

return {
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = { "black", "isort", "mypy", "rope" },
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {
			automatic_installation = true,
		},
	},
	{
		"simrat39/symbols-outline.nvim",
		config = true,
		keys = {
			{ "<leader>lz" },
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
			local mason_lspconfig = require("mason-lspconfig")
			local lspconfig = require("lspconfig")
			local util = require("lspconfig/util")

			mason_lspconfig.setup_handlers({
				-- will get called for all lsp setup
				function(server_name)
					lspconfig[server_name].setup({
						on_attach = common_on_attach,
						capabilities = lsp_capabilities,
					})
				end,
			})

			lspconfig.lua_ls.setup({
				on_attach = common_on_attach,
				capabilities = lsp_capabilities,
				filetype = { "lua" },
			})
			lspconfig.pyright.setup({
				on_attach = common_on_attach,
				capabilities = lsp_capabilities,
				filetype = { "python" },
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							diagnosticMode = "workspace",
							useLibraryCodeForTypes = true,
						},
					},
				},
			})
			lspconfig.rust_analyzer.setup({
				on_attach = common_on_attach,
				capabilities = lsp_capabilities,
				filetype = { "rust" },
				root_dir = util.root_pattern("Cargo.toml"),
				settings = {
					["rust_analyzer"] = {
						cargo = {
							allFeatures = true,
						},
					},
				},
			})
			lspconfig.bitbake_ls.setup({
				on_attach = common_on_attach,
				capabilities = lsp_capabilities,
			})
      lspconfig.yamlls.setup({
				on_attach = common_on_attach,
				capabilities = lsp_capabilities,
      })

			vim.lsp.set_log_level("debug")

			local open_floating_preview = vim.lsp.util.open_floating_preview
			function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
				opts = opts or {}
				opts.border = opts.border or "rounded"
				return open_floating_preview(contents, syntax, opts, ...)
			end
		end,
		opts = {
			diagnostics = {
				signs = true,
				underline = true,
				update_in_insert = false,
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●",
				},
				severity_sort = true,
				float = {
					show_header = true,
					border = "rounded",
					source = "always",
				},
			},
		},
	},
	{
		"nvimtools/none-ls.nvim",
		opts = function()
			local module = require("null-ls")
			return {
				sources = {
					module.builtins.formatting.stylua,
					module.builtins.formatting.black,
					module.builtins.formatting.isort,
					-- module.builtins.formatting.rustfmt,
					-- module.builtins.diagnostics.mypy,
					module.builtins.diagnostics.pylint,
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({
							group = augroup,
							buffer = bufnr,
						})
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ bufnr = bufnr, async = false })
							end,
						})
					end
				end,
			}
		end,
		keys = {
			{ "<leader>lf", vim.lsp.buf.format, mode = { "n", "v" }, desc = "Format File" },
		},
	},
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			"nvimtools/none-ls.nvim",
		},
		opts = {
      automatic_installation = true
		},
	},
}
