return {
	{
		"nvim-mini/mini.nvim",
		version = false,

		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
			},
		},
		config = function()
			local spec_treesitter = require("mini.ai").gen_spec.treesitter
			require("mini.ai").setup({
				n_lines = 300,

				custom_textobjects = {
					F = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
					o = spec_treesitter({
						a = { "@conditional.outer", "@loop.outer" },
						i = { "@conditional.inner", "@loop.inner" },
					}),
				},
			})
			require("mini.surround").setup()
			require("mini.align").setup()
			require("mini.cmdline").setup()
			require("mini.icons").setup()
			require("mini.pairs").setup()
			require("mini.move").setup()
			require("mini.splitjoin").setup()
			require("mini.cursorword").setup()
			require("mini.statusline").setup({ use_icons = true })
		end,
	},
}
