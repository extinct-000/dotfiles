return{
    {
	'akinsho/bufferline.nvim',
	version = "*",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = 'nvim-tree/nvim-web-devicons',
	config = function()
	    vim.opt.termguicolors = true
	    require("bufferline").setup()
	    -- rest of config ...

	    --- count is an integer representing total count of errors
	    --- level is a string "error" | "warning"
	    --- diagnostics_dict is a dictionary from error level ("error", "warning" or "info")to number of errors for each level.
	    --- this should return a string
	    --- Don't get too fancy as this function will be executed a lot

	    diagnostics_indicator = function(count, level, diagnostics_dict, context)
		local s = " "
		for e, n in pairs(diagnostics_dict) do
		    local sym = e == "error" and " "
		    or (e == "warning" and " " or " ")
		    s = s .. n .. sym
		end
		return s
	    end
	end

    }
}
