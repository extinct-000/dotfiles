return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({

			formatters_by_ft = {

				lua = { "stylua" },
				python = { "ruff_format" },
				javascript = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
			},

			formatters = {
				stylua = {

					prefer_local = true,
				},
			},
			default_format_opts = {
				lsp_format = "never",
			},
		})
	end,
}
