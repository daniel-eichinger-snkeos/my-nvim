return {
  { -- Fuzzy Finder (files, lsp, etc.)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      local actions = require 'telescope.actions'
      local fd = vim.fn.has 'win32' == 1 and 'fd' or 'fdfind'
      require('telescope').setup {
        defaults = {
          find_command = { fd, '--type', 'f', '--hidden', '--exclude', '.git' },
          mappings = {
            i = {
              ['<C-j>'] = 'move_selection_next',
              ['<C-k>'] = 'move_selection_previous',
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', function()
        builtin.find_files {
          hidden = true,
          find_command = { fd, '--type', 'f', '--hidden', '--exclude', '.git' },
        }
      end, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', function()
        builtin.live_grep {
          additional_args = function()
            return { '--hidden', '--glob', '!.git/*', '--glob', '!node_modules/*' }
          end,
        }
      end, { desc = '[S]earch by [G]rep (hidden, no .git/node_modules)' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>sc', builtin.colorscheme, { desc = '[S]earch [C]olorscheme' })

      -- Git status via Telescope
      vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = '[G]it [S]tatus' })

      -- Fuzzy search in current buffer
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- Live grep in open files
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Search Neovim config files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })

      -- Browse and cd into projects from dev folder
      vim.keymap.set('n', '<leader>sp', function()
        local project_root = vim.fn.has 'win32' == 1 and 'C:/dev' or '/home/daniel/dev2'
        builtin.find_files(require('telescope.themes').get_dropdown {
          prompt_title = 'Open Directory',
          cwd = project_root,
          previewer = false,
          find_command = { fd, '--type', 'd', '--max-depth', '1' },
          attach_mappings = function(_, map)
            local action_state = require 'telescope.actions.state'
            map('i', '<CR>', function(prompt_bufnr)
              local entry = action_state.get_selected_entry()
              actions.close(prompt_bufnr)
              local new_dir = vim.fs.joinpath(project_root, entry[1])
              vim.uv.chdir(new_dir)
              vim.cmd('cd ' .. vim.fn.fnameescape(new_dir))
              vim.cmd('Oil ' .. new_dir)
            end)
            return true
          end,
        })
      end, { desc = '[S]earch [p]rojects' })
    end,
  },
}
