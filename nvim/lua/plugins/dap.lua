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

return {
  'mfussenegger/nvim-dap',

  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'theHamsta/nvim-dap-virtual-text',
      opts = {
        highlight_new_as_changed = true,
      },
    },
  },

  cmd = {
    'RustDebugBin',
    'RustDebugTests',
  },

  keys = {
    { '<F5>',  function() require('dap').continue() end },
    { '<F9>',  function() require('dap').terminate() end },
    { '<F10>', function() require('dap').step_over() end },
    { '<F11>', function() require('dap').step_into() end },
    { '<F12>', function() require('dap').step_out() end },
    {
      '<leader>dd',
      function() require('dap').toggle_breakpoint() end,
      desc = 'toggle breakpoint'
    },
    {
      '<leader>dC',
      function() require('dap').clear_breakpoints() end,
      desc = 'clear breakpoints'
    },
    {
      '<leader>dD',
      function()
        require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
      end,
      desc = 'breakpoint condition'
    },
  },

  config = function()
    local dap = require('dap')
    local scandir = require('plenary.scandir')
    local job = require('plenary.job')

    local extensions_dir = vim.env.HOME .. '/.vscode/extensions'
    local dirs = scandir.scan_dir(extensions_dir, {
      depth = 1,
      only_dirs = true,
    })

    local vscode_pattern = 'vadimcn%.vscode%-lldb%-%d%.%d%.%d'
    local vscode_dir = ''
    for _, entry in ipairs(dirs) do
      local is_vscode_lldb = string.find(entry, vscode_pattern) ~= nil
      if is_vscode_lldb then
        vscode_dir = entry
        break
      end
    end

    if vscode_dir == '' then
      error('Could not find vscode-lldb extension')
    end

    local this_os = vim.loop.os_uname().sysname
    local is_windows = this_os:find('Windows')
    local codelldb_path = vscode_dir .. '/adapter/codelldb' .. (is_windows and '.exe' or '')

    local function pick_executable()
      local path = vim.fn.input({
        prompt = 'Path to executable: ',
        default = vim.fn.getcwd() .. '/',
        completion = 'file',
      })
      vim.notify(path)
      return path
    end

    local codelldb_launch = {
      {
        name = 'CodeLLDB Launch',
        type = 'codelldb',
        request = 'launch',
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        program = pick_executable,
      },
    }

    local gdb_launch = {
      name = 'GDB Launch',
      type = 'gdb',
      request = 'launch',
      cwd = '${workspaceFolder}',
      program = pick_executable,
    }

    local configs = { codelldb_launch, gdb_launch }

    dap.configurations = {
      c = configs,
      cpp = configs,
      rust = configs,
    }

    local detached = nil
    if is_windows then
      detached = false
    end

    dap.adapters = {
      gdb = {
        type = 'executable',
        command = 'gdb',
        args = { '-i', 'dap' },
      },

      codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
          command = codelldb_path,
          args = { '--port', '${port}' },
          detached = detached,
        }
      }
    }

    local last_path_item = function(path)
      return string.match(path, '[^\\/]+$')
    end

    local run_rust = function(program)
      dap.run({
        name = string.format('Rust run %s', last_path_item(program)),
        program = program,
        type = 'gdb',
        request = 'launch',
        cwd = '${workspaceFolder}',
      })
    end

    local function debug_rust(extra_args)
      job:new({
        command = 'cargo',
        args = { 'build', '--message-format', 'json', unpack(extra_args) },
        cwd = vim.fn.getcwd(),
        on_exit = function(self, code)
          vim.schedule(function()
            if code ~= 0 then
              vim.notify('Compilation error', vim.log.levels.WARN)
              return
            end

            local programs = {}
            for _, result in ipairs(self:result()) do
              local json = vim.fn.json_decode(result)
              if json == nil or not json.fresh or type(json.executable) ~= 'string' then
                goto continue
              end
              table.insert(programs, json.executable)
              ::continue::
            end

            if #programs == 1 then
              run_rust(programs[1])
            else
              vim.ui.select(
                programs,
                {
                  prompt = 'Select test binary:',
                  format_item = last_path_item,
                },
                function(choice)
                  run_rust(choice)
                end
              )
            end
          end)
        end
      }):start()
    end

    vim.api.nvim_create_user_command('RustDebugBin', function()
      debug_rust({})
    end, {})

    vim.api.nvim_create_user_command('RustDebugTests', function()
      debug_rust({ '--tests' })
    end, {})
  end
}
