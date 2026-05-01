return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'github/copilot.vim',
    'cairijun/codecompanion-agentskills.nvim',
  },
  opts = {
    opts = {
      log_level = 'DEBUG',
    },
  },
  config = function()
    require('codecompanion').setup {
      extensions = {
        agentskills = {
          opts = {
            paths = {
              { '~/.config/nvim/skills/.agents/skills', recursive = true }, -- Recursive search
            },
          },
        },
      },
    }
  end,
}
