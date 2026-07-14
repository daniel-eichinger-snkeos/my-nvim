return {
  { -- Floating terminal
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      direction = 'float',
      shell = 'zsh',
    },
    keys = {
      { '<LocalLeader>tt', '<cmd>ToggleTerm<cr>', mode = { 'n', 'v' }, noremap = true, silent = true, desc = '[T]oggle [T]erminal' },
    },
  },
}
