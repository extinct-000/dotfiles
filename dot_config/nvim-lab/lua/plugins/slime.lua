return {
	{
		"jpalardy/vim-slime",
		init = function()
			vim.g.slime_target = "wezterm"

			-- Important for IPython
			-- vim.g.slime_python_ipython = 1
			vim.g.slime_bracketed_paste = 1
			vim.g.slime_dont_ask_default = 1

			-- keymaps
			vim.keymap.set("x", "<leader>pr", "<Plug>SlimeRegionSend")
			vim.keymap.set("n", "<leader>pl", "<Plug>SlimeLineSend")

			-- NEW: send whole paragraph/block
			vim.keymap.set("n", "<leader>pp", "<Plug>SlimeParagraphSend")

			vim.keymap.set("n", "<leader>wp", function()
				local output = vim.fn.system("wezterm cli list --format json")

				local panes = vim.json.decode(output)

				local items = {}
				local pane_ids = {}

				for _, pane in ipairs(panes) do
					if not pane.is_active then
						table.insert(items, string.format("[%s] pane:%s", pane.workspace, pane.pane_id))

						table.insert(pane_ids, tostring(pane.pane_id))
					end
				end

				local choice = vim.fn.inputlist(vim.list_extend({ "Select REPL:" }, items))

				if choice > 0 then
					vim.b.slime_config = {
						pane_id = pane_ids[choice],
					}

					vim.notify("Attached to pane " .. pane_ids[choice])
				end
			end)
		end,
	},
}
