return {
  { -- Git signs in the gutter + keymaps
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function()
        vim.keymap.set('n', '<leader>gm', ':Gitsigns diffthis main<cr>', { silent = true, desc = '[G]it diff against [m]ain' })
        vim.keymap.set('n', '<leader>gb', ':Gitsigns blame<cr>', { silent = true, desc = '[G]it [b]lame' })
      end,
    },
  },
  { -- Git UI
    'NeogitOrg/neogit',
    lazy = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
      'm00qek/baleia.nvim', -- ANSI color in log pager
    },
    cmd = 'Neogit',
    keys = {
      { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Show Neogit UI' },
    },
  },
}
