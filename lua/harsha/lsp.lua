local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)


local on_attach = function(_, bufnr)
  if pcall(require, "lsp_signature") then
    require("lsp_signature").on_attach({
            bind = true,
            handler_opts = {
                border = "single",
            }
        }, bufnr)
  end

  -- local keymap_opts = {silet = true, buffer = true}
  local keymap_opts = {buffer = bufnr}

  -- vim.keymap.set('n','gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = '[G]oto [D]eclaration'})

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, keymap_opts)
  vim.keymap.set('n', "gr", require('telescope.builtin').lsp_references, keymap_opts)

  vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
  end, keymap_opts)

  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, keymap_opts)
  vim.keymap.set('n','<leader>rn', vim.lsp.buf.rename, keymap_opts)
  vim.keymap.set('n','<leader>ca', vim.lsp.buf.code_action, keymap_opts)

  vim.keymap.set('n','<leader>ld', vim.lsp.buf.type_definition, keymap_opts)
  vim.keymap.set('n','<leader>lds', require('telescope.builtin').lsp_document_symbols, keymap_opts)
  vim.keymap.set('n','<leader>lws', require('telescope.builtin').lsp_dynamic_workspace_symbols, keymap_opts)

  vim.keymap.set('n','<C-k>', vim.lsp.buf.signature_help, keymap_opts)

  vim.keymap.set("n", "<Leader>lf", vim.lsp.buf.format, keymap_opts)

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end


local servers = {
  -- ltex = {},
  grammarly = {
    filetypes = {"markdown", "text"}
  },
  clangd = {
  cmd = {
    "clangd",
    "--background-index",
    "--cross-file-rename",
    "--clang-tidy",
    "--completion-style=bundled",
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
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
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
                only_current_line = true,
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
require('neodev').setup()

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}
