-- Java LSP configuration using nvim-jdtls
-- This provides better Java support than standard lspconfig

local M = {}

-- Get the lsp module for capabilities and on_attach
local lsp = require('harsha.lsp')

-- Path to jdtls installation (will be managed by Mason)
local jdtls_path = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
local jdtls_bin = jdtls_path .. '/bin/jdtls'

-- Path to the lombok.jar
local lombok_path = jdtls_path .. '/lombok.jar'

-- Determine OS for configuration
local os_config = 'linux'
if vim.fn.has('mac') == 1 then
    if vim.fn.system('uname -m'):match('arm64') then
        os_config = 'mac_arm'
    else
        os_config = 'mac'
    end
elseif vim.fn.has('win32') == 1 then
    os_config = 'win'
end

-- Workspace directory based on project root
local function get_workspace_dir()
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    -- Sanitize project name for filesystem
    project_name = project_name:gsub('[^%w%-_.]', '_')
    local workspace_dir = vim.fn.stdpath('data') .. '/workspace/' .. project_name
    
    -- Ensure workspace directory exists
    local ok, err = pcall(vim.fn.mkdir, workspace_dir, 'p')
    if not ok then
        vim.notify('Failed to create workspace directory: ' .. err, vim.log.levels.WARN)
        -- Fall back to a default workspace
        workspace_dir = vim.fn.stdpath('data') .. '/workspace/default'
        vim.fn.mkdir(workspace_dir, 'p')
    end
    
    return workspace_dir
end

-- Extended capabilities for Java
local extended_capabilities = vim.tbl_deep_extend('force', lsp.capabilities, {
    workspace = {
        configuration = true,
    },
    textDocument = {
        completion = {
            completionItem = {
                snippetSupport = true,
            },
        },
    },
})

-- Enhanced on_attach for Java-specific features
local function java_on_attach(client, bufnr)
    -- Call the base on_attach
    lsp.on_attach(client, bufnr)
    
    -- Java-specific keymaps
    local opts = { buffer = bufnr, silent = true }
    
    -- Eclipse JDTLS specific commands
    vim.keymap.set('n', '<leader>tc', function()
        require('jdtls').test_class()
    end, vim.tbl_extend('force', opts, { desc = 'Test class' }))
    
    vim.keymap.set('n', '<leader>tm', function()
        require('jdtls').test_nearest_method()
    end, vim.tbl_extend('force', opts, { desc = 'Test method' }))
    
    vim.keymap.set('n', '<leader>rf', function()
        require('jdtls').refactor_class()
    end, vim.tbl_extend('force', opts, { desc = 'Refactor class' }))
    
    vim.keymap.set('n', '<leader>rv', function()
        require('jdtls').extract_variable()
    end, vim.tbl_extend('force', opts, { desc = 'Extract variable' }))
    
    vim.keymap.set('v', '<leader>rv', function()
        require('jdtls').extract_variable(true)
    end, vim.tbl_extend('force', opts, { desc = 'Extract variable' }))
    
    vim.keymap.set('n', '<leader>rc', function()
        require('jdtls').extract_constant()
    end, vim.tbl_extend('force', opts, { desc = 'Extract constant' }))
    
    vim.keymap.set('v', '<leader>rc', function()
        require('jdtls').extract_constant(true)
    end, vim.tbl_extend('force', opts, { desc = 'Extract constant' }))
    
    vim.keymap.set('v', '<leader>rm', function()
        require('jdtls').extract_method(true)
    end, vim.tbl_extend('force', opts, { desc = 'Extract method' }))
    
    vim.keymap.set('n', '<leader>ro', function()
        require('jdtls').organize_imports()
    end, vim.tbl_extend('force', opts, { desc = 'Organize imports' }))
    
    -- DAP (Debug Adapter Protocol) integration
    if pcall(require, 'dap') then
        vim.keymap.set('n', '<leader>df', function()
            require('jdtls').test_class()
        end, vim.tbl_extend('force', opts, { desc = 'Debug test class' }))
        
        vim.keymap.set('n', '<leader>dn', function()
            require('jdtls').test_nearest_method()
        end, vim.tbl_extend('force', opts, { desc = 'Debug test method' }))
    end
    
    -- Auto-commands for Java
    vim.api.nvim_create_autocmd('BufWritePost', {
        buffer = bufnr,
        callback = function()
            -- Auto-organize imports on save
            vim.defer_fn(function()
                require('jdtls').organize_imports()
            end, 100)
        end,
    })
end

-- Get Java executable path
local function get_java_executable()
    -- Try SDKMAN first
    local sdkman_java = vim.fn.expand('~/.sdkman/candidates/java/current/bin/java')
    if vim.fn.executable(sdkman_java) == 1 then
        return sdkman_java
    end
    
    -- Fall back to system java
    return 'java'
end

-- Configuration for nvim-jdtls
local config = {
    cmd = {
        get_java_executable(),
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-javaagent:' .. lombok_path,
        '-Xms1g',
        '-Xmx2G',
        '--add-modules=ALL-SYSTEM',
        '--add-opens',
        'java.base/java.util=ALL-UNNAMED',
        '--add-opens',
        'java.base/java.lang=ALL-UNNAMED',
        '-jar',
        vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar'),
        '-configuration',
        jdtls_path .. '/config_' .. os_config,
        '-data',
        get_workspace_dir(),
    },
    
    root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }),
    
    capabilities = extended_capabilities,
    on_attach = java_on_attach,
    
    settings = {
        java = {
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = 'interactive',
                runtimes = {
                    -- Add your Java runtimes here
                    -- Example:
                    -- {
                    --     name = "JavaSE-17",
                    --     path = "/path/to/java17",
                    -- },
                    -- {
                    --     name = "JavaSE-11",
                    --     path = "/path/to/java11",
                    -- },
                }
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            inlayHints = {
                parameterNames = {
                    enabled = 'all', -- literals, all, none
                },
            },
            format = {
                enabled = true,
                settings = {
                    url = vim.fn.stdpath('config') .. '/lang-servers/intellij-java-google-style.xml',
                    profile = 'GoogleStyle',
                },
            },
        },
        signatureHelp = {
            enabled = true,
        },
        completion = {
            favoriteStaticMembers = {
                'org.hamcrest.MatcherAssert.assertThat',
                'org.hamcrest.Matchers.*',
                'org.hamcrest.CoreMatchers.*',
                'org.junit.jupiter.api.Assertions.*',
                'java.util.Objects.requireNonNull',
                'java.util.Objects.requireNonNullElse',
                'org.mockito.Mockito.*',
            },
            importOrder = {
                'java',
                'javax',
                'com',
                'org'
            },
        },
        extendedClientCapabilities = require('jdtls').extendedClientCapabilities,
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            },
        },
        codeGeneration = {
            toString = {
                template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
            },
            useBlocks = true,
        },
    },
    
    init_options = {
        bundles = {}
    },
}

-- Function to setup Java LSP
function M.setup()
    -- Only setup if we're in a Java file
    if vim.bo.filetype ~= 'java' then
        return
    end
    
    -- Check if jdtls is available
    if vim.fn.executable('java') ~= 1 then
        vim.notify('Java is not installed or not in PATH', vim.log.levels.ERROR)
        return
    end
    
    -- Setup debugging support if nvim-dap is available
    if pcall(require, 'dap') then
        config.init_options.bundles = {
            vim.fn.glob(
                vim.fn.stdpath('data') .. '/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar'
            ),
        }
        
        -- Add test bundles if available
        vim.list_extend(config.init_options.bundles, vim.split(vim.fn.glob(
            vim.fn.stdpath('data') .. '/mason/packages/java-test/extension/server/*.jar'
        ), '\n'))
    end
    
    -- Start the LSP
    require('jdtls').start_or_attach(config)
end

-- Autocommand to setup Java LSP when opening Java files
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'java',
    callback = M.setup,
    group = vim.api.nvim_create_augroup('JavaLSP', { clear = true }),
})

return M