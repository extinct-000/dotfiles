return {
    {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	-- lazy = false,
	branch = main,
	build = ":TSUpdate",
    }
}
