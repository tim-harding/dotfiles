return {
  'nvim-lua/plenary.nvim',
  {
    "microsoft/vscode-js-debug",
    build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
  },
  {
    'mxsdev/nvim-dap-vscode-js',
    event = 'VeryLazy',
    config = function()
      require("dap-vscode-js").setup({
        adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
        debugger_path = vim.env.HOME .. '/.local/share/nvim/lazy/vscode-js-debug',
      })
    end
  },
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
      local dap = require('dap')
      local shared = require('shared')

      local function pick_executable()
        local path = vim.fn.input({
          prompt = 'Path to executable: ',
          default = vim.fn.getcwd() .. '/',
          completion = 'file',
        })
        vim.notify(path)
        return path
      end

      local lldb_launch = {
        name = 'LLDB Launch',
        type = 'lldb',
        request = 'launch',
        cwd = '${workspaceFolder}',
        program = pick_executable,
        stopOnEntry = false,
      }

      local codelldb_launch = {
        name = 'CodeLLDB Launch',
        type = 'codelldb',
        request = 'launch',
        cwd = '${workspaceFolder}',
        program = pick_executable,
        stopOnEntry = false,
      }

      local gdb_launch = {
        name = 'GDB Launch',
        type = 'gdb',
        request = 'launch',
        cwd = '${workspaceFolder}',
        program = pick_executable,
        stopOnEntry = false,
      }

      local node_launch = {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
      }

      local node_attach = {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        processId = require 'dap.utils'.pick_process,
        cwd = "${workspaceFolder}",
      }

      local configs_js = { node_launch, node_attach }
      local configs_c = { codelldb_launch, lldb_launch, gdb_launch }

      dap.configurations = {
        c = configs_c,
        cpp = configs_c,
        javascript = configs_js,
        typescript = configs_js,
      }

      local codelldb_path = 'codelldb'
      if shared.is_darwin() then
        codelldb_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/adapter/codelldb'
      end

      dap.adapters = {
        gdb = {
          type = 'executable',
          command = 'gdb',
          args = { '-i', 'dap' },
        },

        lldb = {
          type = 'executable',
          -- This is being renamed to lldb-dap
          command = 'lldb-vscode',
        },

        codelldb = {
          type = 'server',
          port = '${port}',
          executable = {
            command = codelldb_path,
            args = { '--port', '${port}' },
          },
        },
      }

      local function set_condition_breakpoint()
        vim.ui.input({
          prompt = 'Breakpoint condition: ',
        }, function(choice)
          dap.set_breakpoint(choice)
        end)
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
