return {
    "neovim/nvim-lspconfig",

    dependencies = {
        { "folke/neodev.nvim", },
        {
            "williamboman/mason.nvim",
            cmd = "Mason",
            keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
            build = ":MasonUpdate",
            opts = {}
        },
        { "williamboman/mason-lspconfig.nvim" },
        { "WhoIsSethDaniel/mason-tool-installer.nvim" },

        { "j-hui/fidget.nvim",                        opts = {} },
        { "stevearc/conform.nvim" },
    },

    config = function()
        require("neodev").setup {}

        local lspconfig = require("lspconfig")

        local capabilities = nil
        if pcall(require, "cmp_nvim_lsp") then
            capabilities = require("cmp_nvim_lsp").default_capabilities()
        end

        local required_servers = {
            zls = {},
            clangd = {
                -- manual_install = true,
                -- cmd = { "D:\\app\\Clangd\\clangd_snapshot_20240721\\bin\\clangd.exe" }
            },
            lua_ls = {
                server_capabilities = {
                    sematicTokensProvider = vim.NIL,
                },
            },
            rust_analyzer = true,
            pyright = true,
            cmake = {
                cmd = { "cmake-language-server" },
                filetypes = { "cmake" },
                init_options = { buildDirectory = "build" },
            },
            -- fsautocomplete = {},
        }

        local servers_to_install = vim.tbl_filter(function(k)
            local t = required_servers[k]
            if type(t) == "table" then
                return not t.manual_install
            else
                return t
            end
        end, vim.tbl_keys(required_servers))
        -- require("mason-tool-installer").setup { ensure_installed = required_servers }
        require("mason-tool-installer").setup { ensure_installed = servers_to_install }

        for name, config in pairs(required_servers) do
            if config == true then
                config = {}
            end
            config = vim.tbl_deep_extend("force", {}, {
                capabilities = capabilities,
            }, config)

            lspconfig[name].setup(config)
        end

        local disable_semantic_tokens = {
            lua = true,
        }

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local bufnr = args.buf
                local client = assert(vim.lsp.get_client_by_id(args.data.client_id),
                    "must have valid client")

                local settings = required_servers[client.name]
                if type(settings) ~= "table" then
                    settings = {}
                end

                local builtin = require "telescope.builtin"

                vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
                vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0, desc = "[G]oto [D]efinitons" })
                vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0, desc = "[G]oto [R]eferences" })
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0, desc = "[G]oto [D]eclaration" })
                vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0, desc = "[G]oto [T]ype Definition" })
                vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
                vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })
                vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0, desc = "Hover Documentation" })
                vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = 0, desc = "Help Signature" })

                local filetype = vim.bo[bufnr].filetype
                if disable_semantic_tokens[filetype] then
                    client.server_capabilities.semanticTokensProvider = nil
                end

                -- Override server capabilities
                if settings.server_capabilities then
                    for k, v in pairs(settings.server_capabilities) do
                        if v == vim.NIL then
                            ---@diagnostic disable-next-line: cast-local-type
                            v = nil
                        end

                        client.server_capabilities[k] = v
                    end
                end
            end,
        })

        require("conform").setup {
            formatters_by_ft = {
                cpp = { "clang_format" }
            },
        }

        vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function(args)
                require("conform").format {
                    bufnr = args.buf,
                    lsp_fallback = true,
                    quiet = true,
                }
            end,
        })
    end,
}
