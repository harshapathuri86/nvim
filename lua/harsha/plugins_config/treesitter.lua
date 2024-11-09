if not pcall(require, "nvim-treesitter") then
    return
end


require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'cpp', 'lua', 'python', 'java', 'vim', 'markdown', 'markdown_inline', },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = true,

  highlight = {
    enable = true,
    disable = { 'zig' },
  },

  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      -- todo: change this to some usable shortcut
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['a='] = '@assignment.outer',
        ['i='] = '@assignment.inner',
        ['l='] = '@assignment.lhs',
        ['r='] = '@assignment.rhs',

        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',

        ['ai'] = '@conditional.outer',
        ['ii'] = '@conditional.inner',

        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',

        ['am'] = '@function.outer',
        ['im'] = '@function.inner',

        ['af'] = '@call.outer',
        ['if'] = '@call.inner',

        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']f'] = '@call.outer',
        [']m'] = '@function.outer',
        [']i'] = '@conditional.outer',
        [']l'] = '@loop.outer',
        [']c'] = '@class.outer',
        [']s'] = { query = '@scope', query_group = 'locals' },
        [']z'] = { query = '@fold', query_group = 'folds' },
      },
      goto_next_end = {
        [']F'] = '@call.outer',
        [']M'] = '@function.outer',
        [']I'] = '@conditional.outer',
        [']L'] = '@loop.outer',
        [']C'] = '@class.outer',
      },
      goto_previous_start = {
        ['[f'] = '@call.outer',
        ['[m'] = '@function.outer',
        ['[i'] = '@conditional.outer',
        ['[l'] = '@loop.outer',
        ['[c'] = '@class.outer',
      },
      goto_previous_end = {
        ['[F'] = '@call.outer',
        ['[M'] = '@function.outer',
        ['[I'] = '@conditional.outer',
        ['[L'] = '@loop.outer',
        ['[C'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>na'] = '@parameter.inner',
        ['<leader>nm'] = '@function.outer',
        ['<leader>nc'] = '@class.outer',
      },
      swap_previous = {
        ['<leader>pa'] = '@parameter.inner',
        ['<leader>pm'] = '@function.outer',
        ['<leader>pc'] = '@class.outer',
      },
    },
  },
}

local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move");

vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move);
vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite);

vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f);
vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F);
vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t);
vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T);

local parser_config = require(
  'nvim-treesitter.parsers'
).get_parser_configs()

parser_config.ziggy = {
  install_info = {
    url = 'https://github.com/kristoff-it/ziggy',
    includes = { 'tree-sitter-ziggy/src' },
    files = { 'tree-sitter-ziggy/src/parser.c' },
    branch = 'main',
    generate_requires_npm = false,
    requires_generate_from_grammar = false,
  },
  filetype = 'ziggy',
}

parser_config.ziggy_schema = {
  install_info = {
    url = 'https://github.com/kristoff-it/ziggy',
    files = { 'tree-sitter-ziggy-schema/src/parser.c' },
    branch = 'main',
    generate_requires_npm = false,
    requires_generate_from_grammar = false,
  },
  filetype = 'ziggy-schema',
}

parser_config.supermd = {
  install_info = {
    url = 'https://github.com/kristoff-it/supermd',
    includes = { 'tree-sitter/supermd/src' },
    files = {
      'tree-sitter/supermd/src/parser.c',
      'tree-sitter/supermd/src/scanner.c'
    },
    branch = 'main',
    generate_requires_npm = false,
    requires_generate_from_grammar = false,
  },
  filetype = 'supermd',
}

parser_config.supermd_inline = {
  install_info = {
    url = 'https://github.com/kristoff-it/supermd',
    includes = { 'tree-sitter/supermd-inline/src' },
    files = {
      'tree-sitter/supermd-inline/src/parser.c',
      'tree-sitter/supermd-inline/src/scanner.c'
    },
    branch = 'main',
    generate_requires_npm = false,
    requires_generate_from_grammar = false,
  },
  filetype = 'supermd_inline',
}

parser_config.superhtml = {
  install_info = {
    url = 'https://github.com/kristoff-it/superhtml',
    includes = { 'tree-sitter-superhtml/src' },
    files = {
      'tree-sitter-superhtml/src/parser.c',
      'tree-sitter-superhtml/src/scanner.c'
    },
    branch = 'main',
    generate_requires_npm = false,
    requires_generate_from_grammar = false,
  },
  filetype = 'superhtml',
}

vim.filetype.add {
  extension = {
    smd = 'supermd',
    shtml = 'superhtml',
    ziggy = 'ziggy',
    ['ziggy-schema'] = 'ziggy_schema',
  },
}
