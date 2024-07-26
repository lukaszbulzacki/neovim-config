return {
	-- Add indentation guides even on blank lines
	'lukas-reineke/indent-blankline.nvim',
	main = 'ibl',
	-- Enable `lukas-reineke/indent-blankline.nvim`
	-- See `:help indent_blankline.txt`
	opts = {
		enabled = true,
		indent = {
			char = '┊',
			highlight = { 'LineNr' },
		},
		scope = {
			-- show_exact_scope = true,
			show_start = true,
			char = '│',

		},
	},
}
