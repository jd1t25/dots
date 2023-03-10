local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		-- null_ls.builtins.diagnostics.pylint.with({
		-- 	diagnostics_postprocess = function(diagnostic)
		-- 		diagnostic.code = diagnostic.message_id
		-- 	end,
		-- }),
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.prettier,
		-- null_ls.builtins.formatting.yapf,
		null_ls.builtins.formatting.stylua,
	},
	-- you can reuse a shared lspconfig on_attach callback here
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					vim.lsp.buf.formatting_sync()
				end,
			})
		end
	end,
})
