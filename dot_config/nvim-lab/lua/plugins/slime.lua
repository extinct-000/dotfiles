return {
	{
		"jpalardy/vim-slime",
		init = function()
			vim.g.slime_target = "neovim"

			-- Important for IPython
			-- vim.g.slime_python_ipython = 1
			vim.g.slime_bracketed_paste = 1

			-- keymaps
			vim.keymap.set("x", "<leader>tsr", "<Plug>SlimeRegionSend")
			vim.keymap.set("n", "<leader>tsl", "<Plug>SlimeLineSend")
			vim.keymap.set("n", "<leader>|", function()
				vim.cmd("botright vsplit | term")

				for _, buffnr in ipairs(vim.api.nvim_list_bufs()) do
					local job_id = vim.b[buffnr].terminal_job_id
					if job_id then
						vim.g.slime_default_config = {
							jobid = job_id,
						}
						print(string.format("Job : %d , buff_no : %d", job_id, buffnr))
						vim.g.slime_dont_ask_default = 1
						vim.api.nvim_set_hl(0, "NotifyINFOBody", {
							bold = true,
						})
						vim.notify("🐌 Slime is ready! ✨ Buffer #" .. buffnr)
						break
					end
				end
			end)
		end,
		-- NEW: send whole paragraph/block
		-- vim.keymap.set("n", "<leader>pp", "<Plug>SlimeParagraphSend")

		-- vim.keymap.set("n", "<leader>wp", function()
		-- 	local output = vim.fn.system("wezterm cli list --format json")
		--
		-- 	local panes = vim.json.decode(output)
		--
		-- 	local items = {}
		-- 	local pane_ids = {}
		--
		-- 	for _, pane in ipairs(panes) do
		-- 		if not pane.is_active then
		-- 			table.insert(items, string.format("[%s] pane:%s", pane.workspace, pane.pane_id))
		--
		-- 			table.insert(pane_ids, tostring(pane.pane_id))
		-- 		end
		-- 	end
		--
		-- 	local choice = vim.fn.inputlist(vim.list_extend({ "Select REPL:" }, items))
		--
		-- 	if choice > 0 then
		-- 		vim.b.slime_config = {
		-- 			pane_id = pane_ids[choice],
		-- 		}
		--
		-- 		vim.notify("Attached to pane " .. pane_ids[choice])
		-- 	end
		-- end)
	},
}
