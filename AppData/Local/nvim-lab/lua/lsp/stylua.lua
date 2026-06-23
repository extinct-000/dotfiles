local cmp = require('blink.cmp')
return
    {
	cmd = {'stylua','--lsp'},
	filetypes = {'lua'},
	root_markers = { {'.luarc.json', '.luarc.jsonc', }, '.git' },
	-- capabilities = vim.tbl_deep_extent('force',vim.lsp.protocol.make_client_capabilities(),require('blink.cmp').get_lsp_capabilities({},false)),
	capabilities = cmp.get_lsp_capabilities({},false),
	settings = {
	    Lua = {
		runtime = {
		    version = 'LuaJIT',
		},
		diagnostics = {
		    globals = {
			'vim',
			'require'
		    },
		},
		workspace = {
		    library = vim.api.nvim_get_runtime_file("",true),
		},
		telemetry = {
		    enable = false,
		}
	    }
	}
    }


