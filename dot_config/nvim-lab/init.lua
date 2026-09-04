-- Hey future Kaish you have to consistentily comment and maintain this init file and please mention things you are forgetting or hard to recall after sometime of inpractice at the end of this file
vim.loader.enable()
print("advent of neovim")

--
-- Loading the path env for lsps
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
vim.env.PATH = mason_bin .. ":" .. vim.env.PATH

-- Some mintue performance tweaks
-- disable slow runtime plugins
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tohtml = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.opt.shada = "!,'1000,<50,s10,h"
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 10
-- vim.g.loaded_matchit = 1

-- shell change
vim.o.shell = vim.env.SHELL or "/bin/bash"
-- Explicitly set the clipboard checks
vim.g.clipboard = {
	name = "wl-clipboard",
	copy = {
		["+"] = "wl-copy",
		["*"] = "wl-copy",
	},
	paste = {
		["+"] = "wl-paste --no-newline",
		["*"] = "wl-paste --no-newline",
	},
}

require("config.lazy")

-- vim.lsp.config['stylua'] = {
-- 	cmd = {'stylua','--lsp'},
-- 	filetypes = {'lua'},
-- 	root_markers = {{'.luarc.json','.luarc.jsonc'},'.git'},
-- 	settings = { Lua = {
-- 			runtime = {
-- 				version = 'LuaJIT',
-- 			}
-- 		}
-- 	}
-- }
-- local M = {}
-- M.capabilities = vim.lsp.protocol.make_client_capabilities()
--
-- M.capabilities.textDocument.completion.completionItem = {
--   documentationFormat = { "markdown", "plaintext" },
--   snippetSupport = true,
--   preselectSupport = true,
--   insertReplaceSupport = true,
--   labelDetailsSupport = true,
--   deprecatedSupport = true,
--   commitCharactersSupport = true,
--   tagSupport = { valueSet = { 1 } },
--   resolveSupport = {
--     properties = {
--       "documentation",
--       "detail",
--       "additionalTextEdits",
--     },
--   },
-- }

-- Combining the capabilities of nvim and the blink cmp
--
-- local capabilities =
-- 	require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities(), true)
--
-- capabilities.textdocument.foldingrange = {
-- 	dynamicregistration = false,
-- 	linefoldingonly = true,
-- }
--
-- vim.lsp.config("*", {
-- 	capabilities = capabilities,
-- })
--
--
--
--

-- vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities({M.capabilities},false)})
-- vim.lsp.config("*",{capabilities = require(blink.cmp).get_lsp_capabilities()})

-- this has to be done so that lua language server recognize the vim funcions and runtime
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = {
				globals = { "vim" },
				enable = true,
				severity = {
					["unused-local"] = "Warning",
					["unused-function"] = "Warning",
				},
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.fn.expand("$VIMRUNTIME/lua"),
					"${3rd}/luv/library",
				},
			},
			telemetry = { enable = false },
			completion = {
				callSnippet = "Replace",
			},
		},
	},
})
-- local util = require("lspconfig.util")
-- vim.lsp.config("rust_analyzer"{root_dir = function(fname)
--     return util.root_pattern("Cargo.toml", ".git")(fname) or vim.fn.expand("%:p:h")
-- end,})

-- local util = require("lspconfig.util")
-- local root_dir = function(fname)
--     return util.root_pattern("Cargo.toml", "rust-project.json", ".git")(fname)
--         or vim.fn.expand("%:p:h")  -- fallback: folder containing current file
-- end

-- vim.lsp.config("rust_analyzer",{
--     filetypes = {"rust"},
--     cmd = {"rust-analyzer"},
--     root_dir = root_dir,
--     settings= {
-- 	["rust-analyzer"] = {
-- 	    imports = {
-- 		granularity = {
-- 		    group = "module",
-- 		},
-- 		prefix = "self",
-- 	    },
-- 	    cargo = {
-- 		allFeatures = true,
-- 		buildScripts = {
-- 		    enable = true,
-- 		},
-- 	    },
-- 	    procMacro = {
-- 		enable = true
-- 	    },
-- 	},
--     },
-- })

-- vim.lsp.config("rust_analyzer",{
--     root_markers = {".git"},
-- })
-- Explicitly setting the Virtual Environment for the python intepreter this method is done only to save my personal time not recommended

vim.lsp.config("ty", {
	root_markers = { ".git", "pyproject.toml", "requirements.txt" },
})

--
--

local servers = { "lua_ls", "racket_langserver", "rust_analyzer", "ty", "gopls", "vtsls" }
for i = 1, #servers do
	vim.lsp.enable(servers[i])
end

-- making diagnostic inline
vim.diagnostic.config({
	virtual_text = {
		spacing = 2,
		prefix = "●",
	},

	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.guicursor = table.concat({ "n-v-c:block", "i:block", "r:block" }, ",")
vim.opt.undofile = true
vim.opt.signcolumn = "yes:1"
-- vim.opt.statuscolumn = "%l  "

vim.o.updatetime = 300
vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamedplus"

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("v", "<space>x", ":lua<CR>")
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { silent = true })
vim.keymap.set("t", "<Esc>", [[<c-\><c-n>]])
vim.keymap.set("t", "jk", [[<c-\><c-n>]])
vim.keymap.set("n", "<leader>sz", ":lua Snacks.picker.zoxide()<CR>")

vim.keymap.set("n", "<leader>O", function()
	local count = vim.v.count1
	local keys = ""

	for _ = 1, count - 1 do
		keys = keys .. "O<Esc>"
	end

	keys = keys .. "O"

	vim.api.nvim_feedkeys(vim.keycode(keys), "n", false)
end)

vim.keymap.set("n", "<leader>rg", ':lua Snacks.terminal("go run " .. vim.fn.expand("%"),{auto_close = false})<CR> ')
vim.keymap.set("n", "<leader>rp", ':lua Snacks.terminal("python " .. vim.fn.expand("%"),{auto_close = false})<CR> ')
vim.keymap.set("n", "<leader>rm", function()
	local file = vim.fn.expand("%:p")
	local cwd = vim.fn.getcwd()

	local relative = vim.fn.fnamemodify(file, ":.")
	local module = relative:gsub("%.py$", ""):gsub("/", ".")

	Snacks.terminal("uv run python -m " .. module, {
		auto_close = false,
	})
end)
vim.keymap.set("n", "<leader>lr", ":lua vim.lsp.buf.rename()<CR> ")
vim.keymap.set("n", "<leader>ga", ':lua Snacks.terminal("git add -p <C-r><C-f> ",{auto_close = false})<CR> ')

-- Highlight text upon yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
-- Launch the Treesitter only when we have the required treesitter installed
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		local lang = vim.treesitter.language.get_lang(ft)

		if lang then
			vim.notify(
				string.format(
					"🌳✨ Treesitter is ready! 🧩🚀 Buffer #%d is now syntax-aware! ⚡",
					vim.api.nvim_get_current_buf()
				),
				vim.log.levels.INFO
			)
			vim.keymap.set("n", "<leader>fm", function()
				require("conform").format()
				vim.api.nvim_command("write")

				vim.notify("✨ Formatted & saved successfully! 💾⚡", vim.log.levels.INFO)
			end, {
				desc = "FORMAT via LSP & SAVE",
			})
			pcall(vim.treesitter.start, args.buf, lang)
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})

-- This is to hover diagnostic upon CursorHold
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false })
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local opts = { buffer = ev.buf }

		vim.notify(
			string.format(
				"🔌✨ LSP connected! 🧠🚀 Buffer #%d is now language-powered! ⚡",
				vim.api.nvim_get_current_buf()
			),
			vim.log.levels.INFO
		)

		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, opts)
	end,
})

-- This is to erase highlight after search a word using '/'
vim.keymap.set("n", "<Esc>", function()
	if vim.v.hlsearch == 1 then
		vim.cmd("nohlsearch")
	else
		return "<Esc>"
	end
end, { expr = true, silent = true })

-- Normal line numbers (relative ones)
vim.api.nvim_set_hl(0, "LineNrAbove", {
	fg = "#565f89",
	bold = true,
})

-- Normal line numbers (relative ones)
vim.api.nvim_set_hl(0, "LineNrBelow", {
	fg = "#565f89",
	bold = true,
})
-- Current line number
vim.api.nvim_set_hl(0, "CursorLineNr", {
	fg = "#7aa2f7", -- tokyo night blue
	bold = true,
})
-- NOTE:

vim.opt.list = true

vim.opt.listchars = {
	lead = "·",
	tab = "→ ",
	trail = "·",
}
--
--
--
--
-- Hey don't forget to run lazy sync after new plugins installed or making edit to config files
