if not pcall(require, "cmp_nvim_lsp") then
    return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)


local on_attach = function(client, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end
    local imap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('i', keys, func, { buffer = bufnr, desc = desc })
    end

    if pcall(require, "lsp_signature") then
        require("lsp_signature").on_attach({
            bind = true,
            handler_opts = {
                border = "single",
            }
        }, bufnr)
    end


    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[S]earch [D]oc [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[S]earch [W]orkspace [S]ymbols')
    nmap('<leader>li', vim.lsp.buf.incoming_calls, '[L]ist [I]ncoming calls')
    nmap('<leader>lo', vim.lsp.buf.outgoing_calls, '[L]ist [O]utgoing calls')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-h>', vim.lsp.buf.signature_help, 'Signature Documentation')
    imap('<C-h>', vim.lsp.buf.signature_help, 'Signature Help')


    nmap("]d", vim.diagnostic.goto_next, 'Diagnostic next')
    nmap("[d", vim.diagnostic.goto_prev, 'Diagnostic prev')
    nmap('<space>e', vim.diagnostic.open_float, 'Open Diagnostic')
    nmap('<space>q', vim.diagnostic.setloclist, 'Diagnostic loclist')


    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')


    if client.server_capabilities.documentSymbolProvider then
        require('nvim-navic').attach(client, bufnr)
    end

    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true)
    end

    vim.api.nvim_buf_create_user_command(
        bufnr,
        "Format",
        function()
            vim.lsp.buf.format()
        end,
        {}
    )


    vim.api.nvim_create_autocmd(
        { "BufWritePre" },
        {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format()
            end,
        }
    )
end


local servers = {
    ltex = {},
    clangd = {
        cmd = {
            "clangd",
            "--background-index",
            "--suggest-missing-includes",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--cross-file-rename",
            "-isystem",
            "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/c++/v1/",
        },
    },
    gopls = {},
    pyright = {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = "workspace",
                    useLibraryCodeForTypes = true,
                },
            },
        },
    },
    jdtls = {},
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            hint = { enable = true }
        },
    },
    ocamllsp = {},
}

if pcall(require, "rust-tools") then
    local rt = require("rust-tools")
    local opts = {
        tools = {
            executor = require("rust-tools.executors").termopen,
            on_initialized = nil,
            reload_workspace_from_cargo_toml = true,
            inlay_hints = {
                auto = true,
                only_current_line = false,
                show_parameter_hints = true,
                parameter_hints_prefix = "<- ",
                other_hints_prefix = "=> ",
                max_len_align = false,
                max_len_align_padding = 1,
                right_align = false,
                right_align_padding = 7,
                highlight = "Comment",
            },
            hover_actions = {
                border = {
                    { "╭", "FloatBorder" },
                    { "─", "FloatBorder" },
                    { "╮", "FloatBorder" },
                    { "│", "FloatBorder" },
                    { "╯", "FloatBorder" },
                    { "─", "FloatBorder" },
                    { "╰", "FloatBorder" },
                    { "│", "FloatBorder" },
                },
                max_width = nil,
                max_height = nil,
                auto_focus = false,
            },
            crate_graph = {
                backend = "x11",
                output = nil,
                full = true,
                enabled_graphviz_backends = { "bmp", "cgimage", "canon", "dot",
                    "gv", "xdot", "xdot1.2", "xdot1.4", "eps", "exr",
                    "fig", "gd", "gd2", "gif", "gtk", "ico", "cmap",
                    "ismap", "imap", "cmapx", "imap_np", "cmapx_np",
                    "jpg", "jpeg", "jpe", "jp2", "json", "json0", "dot_json",
                    "xdot_json", "pdf", "pic", "pct", "pict", "plain",
                    "plain-ext", "png", "pov", "ps", "ps2", "psd", "sgi",
                    "svg", "svgz", "tga", "tiff", "tif", "tk", "vml", "vmlz",
                    "wbmp", "webp", "xlib", "x11",
                },
            },
        },
        server = {
            standalone = true,
            on_attach = on_attach,
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            settings = {
                ["rust-analyzer"] = {
                    procMacro = {
                        enable = true,
                        attributes = { enabled = true, }
                    },
                    checkOnSave = {
                        allFeatures = true,
                        overrideCommand = {
                            "cargo", "clippy", "--workspace", "--message-format=json",
                            "--all-targets", "--all-features", "--no-deps",
                        }
                    }
                },
            },
        },
        dap = {
            adapter = {
                type = "executable",
                command = "lldb-vscode",
                name = "rt_lldb",
            },
        },
    }

    rt.setup(opts)
end

-- Setup neovim lua configuration
require('neodev').setup({
    library = { plugins = { "nvim-dap-ui" }, types = true },
})

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
    function(server_name)
        if server_name == 'jdtls' then
            require('java').setup {
                -- Your custom jdtls settings goes here
            }

            require('lspconfig').jdtls.setup {
                -- Your custom nvim-java configuration goes here
            }
        end
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            -- filetypes = (servers[server_name] or {}).filetypes,
        }
    end,
}


require('fidget').setup({
    text = {
        spinner = 'arc'
    },
})
