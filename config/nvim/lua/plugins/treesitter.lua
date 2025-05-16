require('nvim-treesitter.configs').setup({
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { 'lua', 'bash', 'tmux' },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },

  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['ia'] = { query = '@parameter.inner', desc = 'Select inner part of a parameter region' },
        ['aa'] = { query = '@parameter.outer', desc = 'Select outer part of a parameter region' },
        ['if'] = { query = '@function.inner', desc = 'Select inner part of a function region' },
        ['af'] = { query = '@function.outer', desc = 'Select outer part of a function region' },
        ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
        ['ac'] = { query = '@class.outer', desc = 'Select outer part of a class region' },
        ['is'] = { query = '@block.inner', desc = 'Select inner part of a scope region' },
        ['as'] = { query = '@block.outer', desc = 'Select outer part of a scope region' },
      },
    },

    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']f'] = { query = '@function.outer', desc = 'Next method start' },
        [']s'] = { query = '@block.outer', desc = 'Next scope start' },
      },
      goto_next_end = {
        [']F'] = { query = '@function.outer', desc = 'Next method end' },
        [']S'] = { query = '@block.outer', desc = 'Next scope end' },
      },
      goto_previous_start = {
        ['[f'] = { query = '@function.outer', desc = 'Previous method start' },
        ['[s'] = { query = '@block.outer', desc = 'Previous scope start' },
      },
      goto_previous_end = {
        ['[F'] = { query = '@function.outer', desc = 'Previous method end' },
        ['[S'] = { query = '@block.outer', desc = 'Previous scope end' },
      },
    },

    indent = {
      enable = true,
    },
  },
})
