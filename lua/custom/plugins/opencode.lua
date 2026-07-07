return {
  'nickjvandyke/opencode.nvim',
  version = 'v0.10.2', -- newer versions require a more complex setup w/ the snacks terminal
  dependencies = {
    {
      ---@module "snacks"
      'folke/snacks.nvim',
      optional = true,
      opts = {
        input = {}, -- Enhances `ask()`
        picker = { -- Enhances `select()`
          actions = {
            opencode_send = function(...)
              return require('opencode').snacks_picker_send(...)
            end,
          },
          win = {
            input = {
              keys = {
                ['<a-a>'] = { 'opencode_send', mode = { 'n', 'i' } },
              },
            },
          },
        },
      },
    },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {}

    vim.o.autoread = true

    vim.keymap.set({ 'n', 'x' }, '<leader>oa', function()
      require('opencode').ask '@this: '
    end, { desc = '[o]pencode [a]sk' })
    vim.keymap.set({ 'n', 'x' }, '<leader>os', function()
      require('opencode').select()
    end, { desc = '[o]pencode [s]elect' })

    vim.keymap.set('n', '<S-C-u>', function()
      require('opencode').command 'session.half.page.up'
    end, { desc = 'Scroll opencode up' })
    vim.keymap.set('n', '<S-C-d>', function()
      require('opencode').command 'session.half.page.down'
    end, { desc = 'Scroll opencode down' })

    vim.keymap.set('n', '<leader>ot', function()
      require('opencode').toggle()
    end, { desc = '[o]pencode [t]oggle' })
  end,
}
