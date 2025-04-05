--- nvim tree
function delete_default_keymaps(bufnr)
  -- Remove default unused mappings
  local delete_keymap_opt = { buffer = bufnr }
  vim.keymap.del('n', 'g?', delete_keymap_opt)
  vim.keymap.del('n', '<Tab>', delete_keymap_opt)
  vim.keymap.del('n', '<BS>', delete_keymap_opt)
  vim.keymap.del('n', '<C-]>', delete_keymap_opt)
  vim.keymap.del('n', '<C-e>', delete_keymap_opt)
  vim.keymap.del('n', '<C-r>', delete_keymap_opt)
  vim.keymap.del('n', '<C-t>', delete_keymap_opt)
  vim.keymap.del('n', '<C-v>', delete_keymap_opt)
  vim.keymap.del('n', '<C-x>', delete_keymap_opt)

  vim.keymap.del('n', '[c', delete_keymap_opt)
  vim.keymap.del('n', ']c', delete_keymap_opt)
  vim.keymap.del('n', '[e', delete_keymap_opt)
  vim.keymap.del('n', ']e', delete_keymap_opt)

  vim.keymap.del('n', 'D', delete_keymap_opt)
  vim.keymap.del('n', 'L', delete_keymap_opt)
  vim.keymap.del('n', 'M', delete_keymap_opt)
  vim.keymap.del('n', 'O', delete_keymap_opt)
  vim.keymap.del('n', 'P', delete_keymap_opt)
  vim.keymap.del('n', 'S', delete_keymap_opt)

  vim.keymap.del('n', 'a', delete_keymap_opt)
  vim.keymap.del('n', 'bmv', delete_keymap_opt)
  vim.keymap.del('n', 'bt', delete_keymap_opt)
  vim.keymap.del('n', 'bd', delete_keymap_opt)
  vim.keymap.del('n', 'c', delete_keymap_opt)
  vim.keymap.del('n', 'd', delete_keymap_opt)
  vim.keymap.del('n', 'e', delete_keymap_opt)
  vim.keymap.del('n', 'f', delete_keymap_opt)
  vim.keymap.del('n', 'ge', delete_keymap_opt)
  vim.keymap.del('n', 'm', delete_keymap_opt)
  vim.keymap.del('n', 'r', delete_keymap_opt)
  vim.keymap.del('n', 'u', delete_keymap_opt)
  vim.keymap.del('n', 'x', delete_keymap_opt)
end

require('nvim-tree').setup {
  view = {
    width = 35,
  },

  git = {
    show_on_open_dirs = false,
  },

  filters = {
    -- Never show .git folder
    custom = { '^\\.git$', 'node_modules' },
    -- Always show .env
    exclude = { '.env' },
  },

  renderer = {
    special_files = {
      'Makefile',
      'Cargo.toml',
      'README.md',
      'readme.md',
      -- Custom files
      'package.json',
      '.env',
    },
    icons = {
      web_devicons = {
        folder = {
          enable = false,
        },
        file = {
          enable = false,
        },
      },
      show = {
        file = false,
        folder = false,
      },
      git_placement = 'after',
      glyphs = {
        git = {
          unstaged = '~',
          staged = '*',
          untracked = '+',
          unmerged = '!',
          deleted = '-',
          ignored = 'o',
          renamed = '->'
        },
        folder = {
          default = '>',
          arrow_closed = '>',
          arrow_open = 'v',
          empty = '[]',
          empty_open = '[ ]',
          symlink = '~>',
          symlink_open = '~+',
        },
      },
    }
  },

  actions = {
    open_file = {
      window_picker = {
        chars = '1234567890',
      },
    },
  },

  help = {
    sort_by = 'desc',
  },

  ui = {
    confirm = {
      remove = true,
      default_yes = true,
    },
  },

  on_attach = function(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
      return {
        desc = 'nvim-tree: ' .. desc,
        buffer = bufnr,
        noremap = true,
        silent = true,
        nowait = true,
      }
    end

    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
    vim.keymap.set('n', '>', api.tree.change_root_to_node, opts('CD'))
    vim.keymap.set('n', '<', api.tree.change_root_to_parent, opts('Up'))
    vim.keymap.set('n', '|', api.node.open.vertical, opts('Open: Vertical Split'))
    vim.keymap.set('n', '-', api.node.open.horizontal, opts('Open: Horizontal Split'))
    vim.keymap.set('n', '<CR>', api.node.open.no_window_picker, opts('Open: No Window Picker'))
    vim.keymap.set('n', '<2-LeftMouse>', api.node.open.no_window_picker, opts('Open: No Window Picker'))
    vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))

    vim.keymap.set('n', 'i', api.fs.create, opts('Create File or Directory'))
    vim.keymap.set('n', 'cc', api.fs.rename_full, opts('Rename'))
    vim.keymap.set('n', 'rm', api.fs.remove, opts('Delete'))
    vim.keymap.set('n', 'mv', api.fs.cut, opts('Cut'))
    vim.keymap.set('n', 'cp', api.fs.copy.node, opts('Copy'))

    vim.keymap.set('n', '{', api.node.navigate.sibling.prev, opts('Prev Sibling'))
    vim.keymap.set('n', '}', api.node.navigate.sibling.next, opts('Next Sibling'))

    -- close the tree if focus
    vim.keymap.set('n', '<leader>T', api.tree.close, opts('Close'))

    delete_default_keymaps(bufnr)

    -- Makes special files yellow
    vim.cmd('highlight! link NvimTreeSpecialFile Yellow')
  end,
}
