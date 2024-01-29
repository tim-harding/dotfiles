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
  event = 'VeryLazy',

  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'theHamsta/nvim-dap-virtual-text',
      opts = {
        highlight_new_as_changed = true,
      },
    },
  },

  config = function()
    local dap = require('dap')
    local job = require('plenary.job')
    local map = require('shared').map

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
        program = pick_executable,
        stopOnEntry = false,
      },
    }

    local gdb_launch = {
      name = 'GDB Launch',
      type = 'gdb',
      request = 'launch',
      cwd = '${workspaceFolder}',
      program = pick_executable,
      stopOnEntry = false,
    }

    local configs = { codelldb_launch, gdb_launch }

    P(configs)
    dap.configurations = {
      c = configs,
      cpp = configs,
      rust = configs,
    }

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
          command = 'codelldb',
          args = { '--port', '${port}' },
        },
      },
    }

    local last_path_item = function(path)
      return string.match(path, '[^\\/]+$')
    end

    local run_rust = function(program)
      dap.run({
        type = 'codelldb',
        request = 'launch',
        cwd = '${workspaceFolder}',
        name = string.format('Rust run %s', last_path_item(program)),
        program = program,
        stopOnEntry = false,
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

    local function set_condition_breakpoint()
      vim.ui.input({
        prompt = 'Breakpoint condition: ',
      }, function(choice)
        dap.set_breakpoint(choice)
      end)
    end

    map('n', '<F5>', dap.continue)
    map('n', '<F9>', dap.terminate)
    map('n', '<F10>', dap.step_over)
    map('n', '<F11>', dap.step_into)
    map('n', '<F12>', dap.step_out)
    map('n', '<leader>b', dap.toggle_breakpoint, 'toggle breakpoint')
    map('n', '<leader>dC', dap.clear_breakpoints, 'clear breakpoints')
    map('n', '<leader>dD', set_condition_breakpoint, 'breakpoint condition')
  end
}
