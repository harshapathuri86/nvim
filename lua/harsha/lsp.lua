local M = {}

-- Modern LSP configuration for Neovim
-- Uses proper capabilities, better keymaps, and modern patterns

-- Check if nvim-cmp is available
local has_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if not has_cmp then
    vim.notify("nvim-cmp not found, LSP capabilities will be limited", vim.log.levels.WARN)
    return
end

-- Enhanced capabilities with nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_lsp.default_capabilities(capabilities)

-- Add folding capabilities
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

-- Modern diagnostic configuration
vim.diagnostic.config({
    virtual_text = {
        spacing = 4,
        prefix = "●",
        severity = { min = vim.diagnostic.severity.HINT }
    },
    signs = {
        severity = { min = vim.diagnostic.severity.HINT }
    },
    underline = {
        severity = { min = vim.diagnostic.severity.HINT }
    },
    float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
    severity_sort = true,
    update_in_insert = false,
})

-- Define diagnostic signs
local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "󰌵" },
    { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

-- Modern on_attach function
local function on_attach(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    
    -- Keymaps
    local opts = { buffer = bufnr, silent = true }
    
    -- Navigation
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
    
    -- Actions
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('x', '<leader>ca', vim.lsp.buf.code_action, opts)
    
    -- Documentation
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
    
    -- Diagnostics
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
    
    -- Workspace
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    
    -- Formatting
    if client.supports_method('textDocument/formatting') then
        vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format({ async = true })
        end, opts)
        
        -- Format on save
        vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end
    
    -- Inlay hints (Neovim 0.10+)
    if client.supports_method('textDocument/inlayHint') then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        vim.keymap.set('n', '<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
        end, opts)
    end
    
    -- Document highlighting
    if client.supports_method('textDocument/documentHighlight') then
        local group = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = bufnr,
            group = group,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = bufnr,
            group = group,
            callback = vim.lsp.buf.clear_references,
        })
    end
    
    -- Navic breadcrumbs
    if client.supports_method('textDocument/documentSymbol') then
        local has_navic, navic = pcall(require, "nvim-navic")
        if has_navic then
            navic.attach(client, bufnr)
        end
    end
end

-- Server configurations
local servers = {
    -- Lua
    lua_ls = {
        settings = {
            Lua = {
                runtime = { version = 'LuaJIT' },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME,
                        "${3rd}/luv/library"
                    }
                },
                completion = { callSnippet = 'Replace' },
                telemetry = { enable = false },
                hint = { enable = true },
                diagnostics = { globals = { 'vim' } },
            },
        },
    },
    
    -- Python
    pyright = {
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = "openFilesOnly",
                    useLibraryCodeForTypes = true,
                    typeCheckingMode = "basic"
                },
            },
        },
    },
    
    -- Go
    gopls = {
        settings = {
            gopls = {
                completeUnimported = true,
                usePlaceholders = true,
                analyses = {
                    unusedparams = true,
                },
                staticcheck = true,
                gofumpt = true,
            },
        },
    },
    
    -- C/C++
    clangd = {
        cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
        },
        init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
        },
    },
    
    -- JSON
    jsonls = {
        settings = {
            json = {
                schemas = pcall(require, 'schemastore') and require('schemastore').json.schemas() or {},
                validate = { enable = true },
            },
        },
    },
    
    -- YAML
    yamlls = {
        settings = {
            yaml = {
                schemaStore = {
                    enable = false,
                    url = "",
                },
                schemas = pcall(require, 'schemastore') and require('schemastore').yaml.schemas() or {},
            },
        },
    },
    
    -- TypeScript/JavaScript
    ts_ls = {
        settings = {
            typescript = {
                inlayHints = {
                    includeInlayParameterNameHints = 'all',
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                }
            },
            javascript = {
                inlayHints = {
                    includeInlayParameterNameHints = 'all',
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                }
            }
        }
    },
}

-- Setup Mason
require('mason').setup({
    ui = {
        border = "rounded",
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- Setup mason-lspconfig
require('mason-lspconfig').setup({
    ensure_installed = vim.tbl_keys(servers),
    automatic_installation = true,
})

-- Setup LSP servers
for server_name, config in pairs(servers) do
    if server_name == 'jdtls' then
        -- Java LSP is handled separately
        goto continue
    end
    
    local server_config = vim.tbl_deep_extend('force', {
        capabilities = capabilities,
        on_attach = on_attach,
    }, config)
    
    require('lspconfig')[server_name].setup(server_config)
    
    ::continue::
end

-- Setup fidget for LSP progress
local has_fidget, fidget = pcall(require, "fidget")
if has_fidget then
    fidget.setup({
        progress = {
            display = {
                render_limit = 5,
                done_ttl = 3,
                done_icon = "✓",
                done_style = "Constant",
                group_style = "Title",
                icon_style = "Question",
                priority = 30,
                skip_history = true,
                format_message = function(msg)
                    return msg.title
                end,
                format_annote = function(msg)
                    return msg.message
                end,
                format_group_name = function(group)
                    return tostring(group)
                end,
                overrides = {
                    rust_analyzer = { name = "rust-analyzer" },
                },
            },
        },
        notification = {
            window = {
                normal_hl = "Comment",
                winblend = 100,
                border = "none",
                zindex = 45,
                max_width = 0,
                max_height = 0,
                x_padding = 1,
                y_padding = 0,
                align = "bottom",
                relative = "editor",
            },
        },
    })
end

M.capabilities = capabilities
M.on_attach = on_attach
M.servers = servers

return M
