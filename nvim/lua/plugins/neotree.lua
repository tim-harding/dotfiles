return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },

  keys = {
    {
      '<leader>f',
      function()
        require('neo-tree.command').execute({
          toggle = true,
          reveal = true,
        })
      end,
    },

    {
      '<leader>gg',
      function()
        require('neo-tree.command').execute({
          source = 'git_status',
          toggle = true,
          reveal = true,
        })
      end,
    },
  },

  opts = {
    close_if_last_window = true,
    use_default_mappings = false,

    default_component_configs = {
      indent = {
        padding = 0,
      },
      name = {
        trailing_slash = true,
      },
      git_status = {
        symbols = {
          added     = '✚',
          modified  = '',
          deleted   = '',
          renamed   = '󰁕',
          untracked = '',
          ignored   = '',
          unstaged  = '󰄱',
          staged    = '',
          conflict  = '',
        },
      },
    },

    commands = {
      git_unstage_all = function()
        vim.cmd('Git reset')
      end
    },

    window = {
      position = 'current',
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        ['<c-cr>'] = function(state)
          state.commands['open'](state)
          require('neo-tree.command').execute({ action = 'close' })
        end,

        ['<tab>']  = 'close_node',
        ['z']      = 'close_all_nodes',
        ['a']      = 'add',
        ['d']      = 'delete',
        ['r']      = 'rename',
        ['c']      = 'copy',
        ['m']      = 'move',
        ['q']      = 'close_window',
        ['?']      = 'show_help',

        ['s']      = 'git_add_file',
        ['S']      = 'git_unstage_file',
        ['gs']     = 'git_add_all',
        ['gS']     = 'git_unstage_all',
        ['gr']     = 'git_revert_file',
        ['gc']     = 'git_commit',
        ['gp']     = 'git_push',
      },
    },

    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false,
      },
      follow_current_file = {
        -- This will find and focus the file in the active buffer every time
        -- the current file is changed while the tree is open.
        enabled = true,
        -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        leave_dirs_open = false,
      },
      use_libuv_file_watcher = true,
      window = {
        mappings = {
          ['<cr>'] = function(state)
            state.commands['open'](state)
            require('neo-tree.command').execute({ reveal = true })
          end,

          ['<bs>'] = 'navigate_up',
          ['.']    = 'set_root',
          ['[g']   = 'prev_git_modified',
          [']g']   = 'next_git_modified',
        },
      },
    },

    git_status = {
      window = {
        mappings = {
          ['<cr>'] = function(state)
            state.commands['open'](state)
            require('neo-tree.command').execute({
              source = 'git_status',
              reveal = true,
            })
          end,
        },
      },
    },
  },
}
