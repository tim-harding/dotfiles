return {
          cmd = { 'chpl-language-server' },
          filetypes = { 'chapel' },
          autostart = true,
          single_file_support = true,
          root_dir = lspconfig.util.find_git_ancestor,
          settings = {},
        }
