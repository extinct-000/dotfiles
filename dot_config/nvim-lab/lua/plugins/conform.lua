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
					args = { "--config-path", vim.fn.expand("~/.config/stylua/stylua.toml"), "-" },
				},
			},
			default_format_opts = { lsp_format = "never" },
		})
	end,
}
