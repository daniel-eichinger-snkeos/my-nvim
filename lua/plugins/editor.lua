return {
  { -- Detect tabstop and shiftwidth automatically
    'NMAC427/guess-indent.nvim',
    config = function()
      require('guess-indent').setup {
        auto_cmd = true,
        default_indent = 2,
        default_tabstop = 2,
      }
    end,
  },
  { -- Useful plugin to show pending keybinds
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      preset = 'helix',
      delay = 0,
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },
      spec = {
        { '<leader>s', group = '[S]earch' },
        { '<leader>S', group = '[S]ession' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },
  { -- File explorer (buffer-style)
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name)
          return name == '.git' or name == 'node_modules'
        end,
      },
    },
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    lazy = false,
  },
  { -- Highlight TODO/FIXME/etc. comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  { -- Suite: pairs, move, ai, comment, tabline, sessions, statusline, surround, misc
    'echasnovski/mini.nvim',
    config = function()
      require('mini.pairs').setup()

      require('mini.move').setup {
        mappings = {
          left = 'H',
          right = 'L',
          down = 'J',
          up = 'K',
        },
      }

      -- Better Around/Inside textobjects
      -- Examples: va)  yi'  ci"
      require('mini.ai').setup { n_lines = 500 }

      require('mini.comment').setup()

      -- Clickable tabs (create w/ :tabnew); switch tabs with [b
      require('mini.tabline').setup()

      -- Session management:
      --   <Leader>Sn - new session
      --   <Leader>Sr - read session
      --   <Leader>Sd - delete session
      --   <Leader>Sw - write session
      require('mini.sessions').setup()
      local session_new = 'MiniSessions.write(vim.fn.input("Session name: "))'
      vim.keymap.set('n', '<leader>Sn', '<Cmd>lua ' .. session_new .. '<CR>', { desc = '[S]ession [N]ew' })
      vim.keymap.set('n', '<leader>Sd', '<Cmd>lua MiniSessions.select("delete")<CR>', { desc = '[S]ession [d]elete' })
      vim.keymap.set('n', '<leader>Sr', '<Cmd>lua MiniSessions.select("read")<CR>', { desc = '[S]ession [r]ead' })
      vim.keymap.set('n', '<leader>Sw', '<Cmd>lua MiniSessions.write()<CR>', { desc = '[S]ession [w]rite' })

      require('mini.misc').setup()
      -- Auto-set cwd based on project root (.git or Makefile)
      MiniMisc.setup_auto_root()
      -- Restore latest cursor position on file open
      MiniMisc.setup_restore_cursor()

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- Surround operations:
      --   saiw) - surround add inner word with paren
      --   sd'   - surround delete quotes
      --   sr)'  - surround replace ) with '
      require('mini.surround').setup()
    end,
  },
}
