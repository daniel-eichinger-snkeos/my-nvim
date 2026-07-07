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
      interactions = {
        chat = {
          adapter = {
            name = 'copilot',
            model = 'gpt-5.4-mini',
          },
        },
      },
      extensions = {
        agentskills = {
          opts = {
            paths = {
              { '~/.agents/skills', recursive = true },
            },
          },
        },
      },
    }
  end,
}
