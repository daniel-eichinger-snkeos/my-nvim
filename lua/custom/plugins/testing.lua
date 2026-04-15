return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'fredrikaverpil/neotest-golang',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-golang' {
          go_test_args = { '-v', '-count=1' },
        },
      },
    }

    vim.keymap.set('n', '<leader>tr', ':Neotest run<cr>', { silent = true, desc = '[T]est [R]un nearest' })
    vim.keymap.set('n', '<leader>ts', ':Neotest summary<cr>', { silent = true, desc = '[T]est [s]ummary' })
    vim.keymap.set('n', '<leader>to', ':Neotest output<cr>', { silent = true, desc = '[T]est [o]utput' })
    vim.keymap.set('n', '<leader>tp', ':Neotest output-panel<cr>', { silent = true, desc = '[T]est output [p]anel' })
  end,
}
