return {
	"L3MON4D3/LuaSnip",
	event = { "InsertEnter" },
	dependencies = { "rafamadriz/friendly-snippets" },
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load()

		require("luasnip.loaders.from_lua").lazy_load({
			paths = "~/appdata/local/nvim-lab/lua/snippets",
		})
	end,
}
