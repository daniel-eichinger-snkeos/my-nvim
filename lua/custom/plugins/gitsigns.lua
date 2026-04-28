return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        vim.keymap.set('n', '<leader>gm', ':Gitsigns diffthis main<cr>', { silent = true, desc = '[G]it diff against [m]ain' })
        vim.keymap.set('n', '<leader>gb', ':Gitsigns blame<cr>', { silent = true, desc = '[G]it [b]lame' })
      end,
    },
  },
}
