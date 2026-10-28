return {
  { -- Fast file navigation
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      ---@diagnostic disable-next-line: missing-parameter
      harpoon:setup()

      vim.keymap.set('n', '<leader>h', function()
        harpoon:list():add()
      end, { desc = 'Harpoon add file' })
      vim.keymap.set('n', '<C-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Harpoon menu' })
      vim.keymap.set('n', '<leader>1', function()
        harpoon:list():select(1)
      end, { desc = 'Harpoon 1' })
      vim.keymap.set('n', '<leader>2', function()
        harpoon:list():select(2)
      end, { desc = 'Harpoon 2' })
      vim.keymap.set('n', '<leader>3', function()
        harpoon:list():select(3)
      end, { desc = 'Harpoon 3' })
      vim.keymap.set('n', '<leader>4', function()
        harpoon:list():select(4) -- fixed: was incorrectly calling select(3)
      end, { desc = 'Harpoon 4' })
    end,
  },
  { -- Diagnostics list UI
    'folke/trouble.nvim',
    cmd = { 'Trouble' },
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },
      { '<leader>xl', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List (Trouble)' },
      { '<leader>xq', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List (Trouble)' },
      { 'gR', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', desc = 'LSP references/definitions (Trouble)' },
    },
    opts = {},
  },
  { -- Your own HTTP REST client for .http files
    dir = vim.fn.expand '~/dev2/nvim-restclient',
    name = 'nvim-restclient',
    main = 'restclient', -- so `opts` calls require('restclient').setup(opts)
    dependencies = { 'nvim-lua/plenary.nvim' },
    ft = { 'http', 'rest' },
    opts = {
      split = 'vertical',
    },
    keys = {
      { '<leader>rs', '<cmd>RestClientRun<cr>', desc = 'Send request' },
      { '<leader>rs', ':RestClientRun<cr>', mode = 'v', desc = 'Send request (selection)' },
      { '<leader>rc', '<cmd>RestClientCancel<cr>', desc = 'Cancel request' },
    },
  },
  { -- Enhanced quickfix list
    'stevearc/quicker.nvim',
    ft = 'qf',
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
  },
  { -- Browser Markdown preview
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'npm install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
  },
  { -- easily access all Golang docs in nvim
    'fredrikaverpil/godoc.nvim',
    version = '*',
    dependencies = {
      { 'nvim-telescope/telescope.nvim' }, -- optional
    },
    build = 'go install github.com/lotusirous/gostdsym/stdsym@latest', -- optional
    config = function()
      require('godoc').setup {
        window = {
          type = 'vsplit',
        },
        picker = {
          type = 'telescope',
        },
      }
    end,
  },
}
