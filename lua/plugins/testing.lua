return {
  {
    'mfussenegger/nvim-dap',
    lazy = true,
    keys = {
      { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'toggle [d]ebug [b]reakpoint' },
      { '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, desc = '[d]ebug [B]reakpoint' },
      { '<F5>',       function() require('dap').continue() end,          desc = '[d]ebug [c]ontinue (F5)' },
      { '<leader>dC', function() require('dap').run_to_cursor() end,     desc = '[d]ebug [C]ursor' },
      { '<leader>dg', function() require('dap').goto_() end,             desc = '[d]ebug [g]o to line' },
      { '<F10>',      function() require('dap').step_over() end,         desc = '[d]ebug step [o]ver (F10)' },
      { '<F12>',      function() require('dap').step_out() end,          desc = '[d]ebug step [O]ut (F12)' },
      { '<F11>',      function() require('dap').step_into() end,         desc = '[d]ebug [i]nto (F11)' },
      { '<leader>dj', function() require('dap').down() end,              desc = '[d]ebug [j]ump down' },
      { '<leader>dk', function() require('dap').up() end,                desc = '[d]ebug [k]ump up' },
      { '<leader>dl', function() require('dap').run_last() end,          desc = '[d]ebug [l]ast' },
      { '<leader>dp', function() require('dap').pause() end,             desc = '[d]ebug [p]ause' },
      { '<leader>dr', function() require('dap').repl.toggle() end,       desc = '[d]ebug [r]epl' },
      { '<leader>dR', function() require('dap').clear_breakpoints() end, desc = '[d]ebug [R]emove breakpoints' },
      { '<leader>ds', function() require('dap').session() end,           desc = '[d]ebug [s]ession' },
      { '<leader>dt', function() require('dap').terminate() end,         desc = '[d]ebug [t]erminate' },
      { '<leader>dw', function() require('dap.ui.widgets').hover() end,  desc = '[d]ebug [w]idgets' },
    },
  },
  {
    'rcarriga/nvim-dap-ui',
    lazy = true,
    dependencies = {
      'nvim-neotest/nvim-nio',
      'mfussenegger/nvim-dap',
    },
    opts = {},
    config = function(_, opts)
      local dap = require 'dap'
      local dapui = require 'dapui'
      dapui.setup(opts)
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open {}
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close {}
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close {}
      end
    end,
    keys = {
      { '<leader>du', function() require('dapui').toggle {} end, desc = '[d]ap [u]i' },
      { '<leader>de', function() require('dapui').eval() end,    desc = '[d]ap [e]val' },
    },
  },
  {
    'nvim-neotest/neotest',
    lazy = true,
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      {
        'fredrikaverpil/neotest-golang',
        dependencies = {
          'andythigpen/nvim-coverage',
          'leoluz/nvim-dap-go',
        },
      },
      { 'citizenharris/neotest-dotnet' },
    },
    config = function()
      local neotest_golang_opts = {
        runner = 'gotestsum',
        go_test_args = {
          '-v',
          '-count=1',
          '-coverprofile=' .. vim.fn.getcwd() .. '/coverage.out',
        },
      }

      require('neotest').setup {
        adapters = {
          require 'neotest-golang'(neotest_golang_opts),
          require 'neotest-dotnet' {
            discovery_root = 'solution',
          },
        },
        output_panel = {
          open = 'vsplit',
        },
      }

      require('coverage').setup {
        auto_reload = true,
      }

      vim.keymap.set('n', '<leader>ct', '<cmd>CoverageToggle<cr>', { silent = true, desc = '[C]overage [t]oggle' })
      vim.keymap.set('n', '<leader>cs', '<cmd>Coverage<cr><cmd>CoverageSummary<cr>', { silent = true, desc = '[C]overage [s]ummary' })
    end,
    keys = {
      { '<leader>td', function() require('neotest').run.run { suite = false, strategy = 'dap' } end, desc = 'Debug nearest test' },
      { '<leader>tr', ':Neotest run<cr>',          mode = 'n', silent = true, desc = '[T]est [R]un nearest' },
      { '<leader>ts', ':Neotest summary<cr>',      mode = 'n', silent = true, desc = '[T]est [s]ummary' },
      { '<leader>to', ':Neotest output<cr>',       mode = 'n', silent = true, desc = '[T]est [o]utput' },
      { '<leader>tp', ':Neotest output-panel<cr>', mode = 'n', silent = true, desc = '[T]est output [p]anel' },
    },
  },
}
