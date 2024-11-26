--- nvim tree
require('nvim-tree').setup {
  renderer = {
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
        modified = '*',
        git = {
          unstaged = '[~]',
          staged = '[+]',
          untracked = '[#]',
          unmerged = '[!]',
          deleted = '[-]',
          ignored = '[.]',
          renamed = '->'
        },
        folder = {
          default = '>',
          arrow_closed = '>',
          arrow_open = '+',
          empty = '[]',
          empty_open = '[ ]',
          symlink = '~>',
          symlink_open = '~+',
        },
      },
    }
  },
  on_attach = function(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
      return {
        desc = 'nvim-tree: ' .. desc,
        buffer = bufnr, noremap = true,
        silent = true,
        nowait = true,
      }
    end

    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
    vim.keymap.set('n', '>', api.tree.change_root_to_node, opts('CD'))
    vim.keymap.set('n', '<', api.tree.change_root_to_parent, opts('Up'))
    vim.keymap.set('n', 'c', api.fs.create, opts('Create File or Directory'))
  end,
}
