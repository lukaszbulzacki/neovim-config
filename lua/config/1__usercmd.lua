vim.api.nvim_create_user_command("MiniFilesOpen", function()
   MiniFiles.open()
end, {})

vim.api.nvim_create_user_command("MiniFilesWorkspace", function()
	MiniFiles.open(vim.fn.getcwd(), false)
end, {})
