-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    'theHamsta/nvim-dap-virtual-text',
    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'Weissle/persistent-breakpoints.nvim',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  keys = function(_, keys)
    local dap = require 'dap'
    local dapui = require 'dapui'
    return {
      -- Basic debugging keymaps, feel free to change to your liking!
      { '<leader>db', dap.continue, desc = 'Debug: Start/Continue' },
      { '<leader>dsi', dap.step_into, desc = 'Debug: Step Into' },
      { '<leader>dsu', dap.step_over, desc = 'Debug: Step Over' },
      { '<leader>dso', dap.step_out, desc = 'Debug: Step Out' },
      { '<leader>b', dap.toggle_breakpoint, desc = 'Debug: Toggle Breakpoint' },
      {
        '<Leader>dr',
        function()
          require('dap').repl.open()
        end,
        desc = 'Open Repl',
      },
      {
        '<Leader>dl',
        function()
          require('dap').run_last()
        end,
        desc = 'Run Last Repl',
      },
      {
        '<leader>do',
        function()
          dapui.open()
        end,
        desc = '[D]ebug [O]pen DAP UI',
      },
      {
        '<leader>dc',
        function()
          dapui.close()
        end,
        desc = '[D]ebug [C]lose DAP UI',
      },
      {
        '<leader>dt',
        function()
          dapui.toggle()
        end,
        desc = '[D]bug [T]oggle DAP UI',
      },

      {
        '<leader>dx',
        function()
          dap.terminate()
          dapui.close()
        end,
        desc = '[D]ebug Exit Session',
      },

      {
        '<leader>B',
        function()
          dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Debug: Set Breakpoint',
      },
      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      { '<F7>', dapui.toggle, desc = 'Debug: See last session result.' },
      unpack(keys),
    }
  end,
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        enabled = true,
        element = 'repl',
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
      force_buffers = true,
      element_mappings = {},
      expand_lines = true,
      floating = {
        border = 'single',
        mappings = {
          close = { 'q', '<ESC>' },
        },
      },
      layouts = {
        {
          elements = {
            {
              id = 'scopes',
              size = 0.25,
            },
            {
              id = 'breakpoints',
              size = 0.25,
            },
            {
              id = 'stacks',
              size = 0.25,
            },
            {
              id = 'watches',
              size = 0.25,
            },
          },
          position = 'left',
          size = 40,
        },
        {
          elements = { {
            id = 'repl',
            size = 0.5,
          }, {
            id = 'console',
            size = 0.5,
          } },
          position = 'bottom',
          size = 10,
        },
      },
      mappings = {
        edit = 'e',
        expand = { '<CR>', '<2-LeftMouse>' },
        open = 'o',
        remove = 'd',
        repl = 'r',
        toggle = 't',
      },
      render = {
        indent = 1,
        max_value_lines = 100,
      },
    }

    -- Change breakpoint icons
    -- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    -- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    -- local breakpoint_icons = vim.g.have_nerd_font
    --     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
    --   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    -- for type, icon in pairs(breakpoint_icons) do
    --   local tp = 'Dap' .. type
    --   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
    --   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    -- end

    dap.configurations.go = {
      -- {
      --   type = 'go',
      --   name = 'Attach to Process',
      --   request = 'attach',
      --   mode = 'remote',
      --   host = '127.0.0.1',
      --   port = 2345, -- Matches the Delve port
      -- },
      -- {
      --   type = 'go',
      --   name = 'Debug Main',
      --   request = 'launch',
      --   program = '${file}', -- This uses the currently open file
      --   cwd = vim.fn.getcwd(), -- Sets working directory to project root
      --   env = {
      --     CONFIG_PATH = '~/Dev/zportfolio-service/config',
      --   },
      -- },
      -- {
      --   type = 'go',
      --   name = 'Zport Serv',
      --   request = 'launch',
      --   program = '${file}',
      --   args = { '-arg1=value1', '-arg2=value2' }, -- Custom program args
      --   buildFlags = "-gcflags 'all=-N -l'",
      -- },
    }
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup {
      dap_configurations = {
        -- {
        --   type = 'go',
        --   name = 'Attach Rizmote',
        --   mode = 'remote',
        --   request = 'attach',
        -- },
        -- {
        --   type = 'go',
        --   name = 'debug main',
        --   request = 'launch',
        --   program = '${file}',
        --   cwd = '${workspaceFolder}',
        -- },
      },
      delve = {
        -- the path to the executable dlv which will be used for debugging.
        -- by default, this is the "dlv" executable on your PATH.
        path = 'dlv',
        -- time to wait for delve to initialize the debug session.
        -- default to 20 seconds
        initialize_timeout_sec = 20,
        -- a string that defines the port to start delve debugger.
        -- default to string "${port}" which instructs nvim-dap
        -- to start the process in a random available port.
        -- if you set a port in your debug configuration, its value will be
        -- assigned dynamically.
        port = '${port}',
        -- additional args to pass to dlv
        args = {},
        -- the build flags that are passed to delve.
        -- defaults to empty string, but can be used to provide flags
        -- such as "-tags=unit" to make sure the test suite is
        -- compiled during debugging, for example.
        -- passing build flags using args is ineffective, as those are
        -- ignored by delve in dap mode.
        -- avaliable ui interactive function to prompt for arguments get_arguments
        build_flags = "-gcflags 'all=-N -l'",
        -- whether the dlv process to be created detached or not. there is
        -- an issue on Windows where this needs to be set to false
        -- otherwise the dlv server creation will fail.
        -- avaliable ui interactive function to prompt for build flags: get_build_flags
        detached = vim.fn.has 'win32' == 0,
        -- the current working directory to run dlv from, if other than
        -- the current working directory.
        cwd = vim.fn.getcwd(),
      },
      -- options related to running closest test
      tests = {
        -- enables verbosity when running the test.
        verbose = false,
      },
    }
    require('persistent-breakpoints').setup {
      save_dir = vim.fn.stdpath 'data' .. '/breakpoints/',
      load_breakpoints_event = { 'BufReadPost' },
      perf_record_event = { 'BufWritePost' },
    }

    local opts = { noremap = true, silent = true }
    local keymap = vim.api.nvim_set_keymap
    -- Save breakpoints to file automatically.
    keymap('n', '<leader>tpb', "<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<cr>", opts)
    keymap('n', '<leader>tpc', "<cmd>lua require('persistent-breakpoints.api').set_conditional_breakpoint()<cr>", opts)
    keymap('n', '<leader>tca', "<cmd>lua require('persistent-breakpoints.api').clear_all_breakpoints()<cr>", opts)
    keymap('n', '<leader>slp', "<cmd>lua require('persistent-breakpoints.api').set_log_point()<cr>", opts)

    require('nvim-dap-virtual-text').setup()
    -- require('persistent-breakpoints').setup {
    --   load_breakpoints_event = { 'BufReadPost' },
    -- }
  end,
}
