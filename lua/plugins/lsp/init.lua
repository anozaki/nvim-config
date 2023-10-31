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

local common_on_attach = function(client, bufnr)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Goto Definition" })
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Goto Declaration" })
	vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "References" })
	vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Goto Type Definition" })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Goto implementation" })
	vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature Help" })
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover [LSP]" })
	vim.keymap.set("n", "gl", function()
		local float = vim.diagnostic.config().float
		if float then
			local config = type(float) == "table" and float or {}
			config.scope = "line"
			config.border = "rounded"
			vim.diagnostic.open_float(config)
		end
	end, { buffer = bufnr, desc = "Line Info" })

	set_diagnostic_icon()
end

return {
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
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				on_attach = common_on_attach,
				capabilities = capabilities,
				filetype = { "lua" },
			})
			lspconfig.pyright.setup({
				on_attach = common_on_attach,
				capabilities = capabilities,
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
			require("lspconfig").rust_analyzer.setup({
				on_attach = common_on_attach,
				capabilities = capabilities,
				filetype = { "rust" },
			})

			local _border = "rounded"
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = _border,
			})

			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = _border,
			})
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
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = { "black", "isort", "mypy" },
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "lua_ls", "rust_analyzer", "pyright" },
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
					-- module.builtins.formatting.isort,
					module.builtins.formatting.rustfmt,
					module.builtins.diagnostics.mypy,
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
								vim.lsp.buf.format({ bufnr = bufnr })
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
		opts = {
			ensure_installed = {
				"stylua",
				-- "black",
				-- "isort",
				-- "rustfmt",
				-- "mypy",
				-- "pylint",
			},
		},
		dependencies = {
			"nvimtools/none-ls.nvim",
		},
	},
}
