vim.pack.add({ "https://github.com/creativenull/efmls-configs-nvim" })

local lualin = require("efmls-configs.linters.luacheck")
local luafmt = require("efmls-configs.formatters.stylua")

local cpplin = require("efmls-configs.linters.clang_format")
local cppfmt = require("efmls-configs.formatters.clang_format")

local cmakelin = require("efmls-configs.linters.cmake_lint")
local cmakefmt = require("efmls-configs.formatters.gersemi")

vim.lsp.config("efm", {
	filetypes = {
		"c",
		"cpp",
		"cxx",
		"cmake",
		"lua",
	},
	init_options = { documentFormatting = true },
	settings = {
		languages = {
			c = { cppfmt, cpplin },
			cpp = { cppfmt, cpplin },
			cxx = { cppfmt, cpplin },
			cmake = { cmakefmt, cmakelin },
			lua = { lualin, luafmt },
		},
	},
}, { cmd = { "efm-langserver" } })
vim.lsp.enable({ "efm" })
