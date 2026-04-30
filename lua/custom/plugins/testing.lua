return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    {
      'fredrikaverpil/neotest-golang',
      dependencies = {
        'andythigpen/nvim-coverage',
      },
    },
  },
  config = function()
    local neotest_golang_opts = { -- Specify configuration
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
      },
      output_panel = {
        open = 'vsplit', -- open vertically and move to the far left
      },
    }

    require('coverage').setup {
      auto_reload = true,
    }

    vim.keymap.set('n', '<leader>tr', ':Neotest run<cr>', { silent = true, desc = '[T]est [R]un nearest' })
    vim.keymap.set('n', '<leader>ts', ':Neotest summary<cr>', { silent = true, desc = '[T]est [s]ummary' })
    vim.keymap.set('n', '<leader>to', ':Neotest output<cr>', { silent = true, desc = '[T]est [o]utput' })
    vim.keymap.set('n', '<leader>tp', ':Neotest output-panel<cr>', { silent = true, desc = '[T]est output [p]anel' })

    vim.keymap.set('n', '<leader>ct', '<cmd>CoverageToggle<cr>', { silent = true, desc = '[C]overage [t]oggle' })
    vim.keymap.set('n', '<leader>cs', '<cmd>Coverage<cr><cmd>CoverageSummary<cr>', { silent = true, desc = '[C]overage [s]ummary' })
  end,
}
