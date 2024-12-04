return {
  'nvim-lua/plenary.nvim',

  {
    'mfussenegger/nvim-dap-python',
    event = 'VeryLazy',
    config = function()
      require('dap-python').setup('python3')
    end
  },

  {
    'leoluz/nvim-dap-go',
    event = 'VeryLazy',
    opts = {},
  },

  {
    'mfussenegger/nvim-dap',
    event = 'VeryLazy',

    init = function()
      vim.fn.sign_define('DapBreakpoint', {
        text = '●',
        texthl = 'DapBreakpoint',
        linehl = '',
        numhl = '',
      })
      vim.fn.sign_define('DapBreakpointCondition', {
        text = '●',
        texthl = 'DapBreakpointCondition',
        linehl = '',
        numhl = '',
      })
      vim.fn.sign_define('DapLogPoint', {
        text = '◆',
        texthl = 'DapLogPoint',
        linehl = '',
        numhl = '',
      })
    end,

    config = function()
      local dap = require 'dap'
      local shared = require 'shared'

      local function pick_executable()
        local path = vim.fn.input {
          prompt = 'Path to executable: ',
          default = vim.fn.getcwd() .. '/',
          completion = 'file',
        }
        vim.notify(path)
        return path
      end

      local function codelldb_path()
        if shared.is_darwin() then
          return vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/adapter/codelldb'
        else
          return 'codelldb'
        end
      end

      local configs_c = {
        {
          name = 'CodeLLDB Launch',
          type = 'codelldb',
          request = 'launch',
          cwd = '${workspaceFolder}',
          program = pick_executable,
          stopOnEntry = false,
        },
        {
          name = 'LLDB Launch',
          type = 'lldb',
          request = 'launch',
          cwd = '${workspaceFolder}',
          program = pick_executable,
          stopOnEntry = false,
        },
        {
          name = 'GDB Launch',
          type = 'gdb',
          request = 'launch',
          cwd = '${workspaceFolder}',
          program = pick_executable,
          stopOnEntry = false,
        },
      }

      dap.configurations['c'] = configs_c
      dap.configurations['cpp'] = configs_c

      dap.adapters['gdb'] = {
        type = 'executable',
        command = 'gdb',
        args = { '-i', 'dap' },
      }
      dap.adapters['lldb'] = {
        type = 'executable',
        -- This is being renamed to lldb-dap
        command = 'codelldb',
      }
      dap.adapters['codelldb'] = {
        type = 'server',
        port = '${port}',
        executable = {
          command = codelldb_path(),
          args = { '--port', '${port}' },
        },
      }

      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = { vim.env.HOME .. "/Documents/installs/vscode-js-debug/dist/src/dapDebugServer.js", "${port}" },
        }
      }

      dap.adapters['pwa-chrome'] = dap.adapters['pwa-node']

      dap.adapters["firefox"] = {
        type = "executable",
        command = "node",
        args = { vim.env.HOME .. "/Documents/installs/vscode-firefox-debug/dist/adapter.bundle.js" },
      }

      local configs_js = {
        {
          name = "Node debug file",
          type = "pwa-node",
          request = "launch",
          program = "${file}",
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
        {
          name = "Node attach",
          type = "pwa-node",
          request = "attach",
          processId = require 'dap.utils'.pick_process,
          cwd = "${workspaceFolder}",
        },
        {
          name = "Chrome launch",
          type = "pwa-chrome",
          request = "launch",
          runtimeExecutable = "/usr/bin/chromium",
          cwd = "${workspaceFolder}",
          url = 'http://localhost:5173',
          webRoot = "${workspaceFolder}",
        },
        {
          name = "Firefox launch",
          type = "firefox",
          request = "launch",
          reAttach = true,
          url = 'http://localhost:5173',
          firefoxExecutable = '/usr/bin/firefox',
          webRoot = "${workspaceFolder}",
        },
      }

      dap.configurations['javascript'] = configs_js
      dap.configurations['typescript'] = configs_js
      dap.configurations['vue'] = configs_js

      local function set_condition_breakpoint()
        vim.ui.input(
          { prompt = 'Breakpoint condition: ' },
          function(choice)
            dap.set_breakpoint(choice)
          end
        )
      end

      shared.map('n', '<F5>', dap.continue)
      shared.map('n', '<F9>', dap.terminate)
      shared.map('n', '<F10>', dap.step_over)
      shared.map('n', '<F11>', dap.step_into)
      shared.map('n', '<F12>', dap.step_out)
      shared.map('n', '<leader>b', dap.toggle_breakpoint, 'toggle breakpoint')
      shared.map('n', '<leader>dC', dap.clear_breakpoints, 'clear breakpoints')
      shared.map('n', '<leader>dD', set_condition_breakpoint, 'breakpoint condition')
    end
  }
}
