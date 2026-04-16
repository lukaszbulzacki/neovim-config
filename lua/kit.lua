function setget_undodir()
	local undodir = vim.fn.expand("~/.vim/undodir")
	if vim.fn.isdirectory(undodir) ~= 1 then
		vim.fn.mkdir(undodir, "p")
	end
	return undodir
end

function setget_startdir()
	local argn = vim.fn.argc()
	local cdir = vim.fs.normalize(vim.fs.abspath(vim.fn.getcwd()))

	if argn > 0 then
		local argi = 0
		while argi < argn do
			local arge = vim.fs.normalize(vim.fs.abspath(vim.fn.argv(argi)))
			if cdir == arge then
				return cdir
			end
			if vim.fn.isdirectory(arge) == 1 then
				vim.fn.chdir(arge)
				return arge
			end
			argi = argi + 1
		end
	end

	return cdir
end
