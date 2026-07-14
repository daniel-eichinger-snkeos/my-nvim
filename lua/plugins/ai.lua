return {
  { -- AI chat and inline completions via Copilot
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'github/copilot.vim',
      'cairijun/codecompanion-agentskills.nvim',
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
  },
  { -- opencode.ai terminal integration
    'nickjvandyke/opencode.nvim',
    version = 'v0.10.2',
    dependencies = {
      {
        ---@module "snacks"
        'folke/snacks.nvim',
        optional = true,
        opts = {
          input = {},
          picker = {
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

      vim.keymap.set('n', '<S-C-u>', function()
        require('opencode').command 'session.half.page.up'
      end, { desc = 'Scroll opencode up' })
      vim.keymap.set('n', '<S-C-d>', function()
        require('opencode').command 'session.half.page.down'
      end, { desc = 'Scroll opencode down' })
      vim.keymap.set('n', '<leader>ao', function()
        require('opencode').toggle()
      end, { desc = '[a]i [o]pencode chat' })
    end,
  },
}
