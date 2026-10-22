return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
      flavour = 'mocha',
      background = {
        light = 'latte',
        dark = 'mocha',
      },
      transparent_background = false,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        telescope = true,
        native_lsp = {
          enabled = true,
        },
      },
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  -- {
  --   'rebelot/kanagawa.nvim',
  --   priority = 1000,
  --   colors = {
  --     theme = {
  --       all = {
  --         ui = {
  --           bg_gutter = 'none',
  --         },
  --       },
  --     },
  --   },
  --   config = function()
  --     vim.cmd.colorscheme 'kanagawa'
  --   end,
  -- },
  { -- Animated cursor movement
    'sphamba/smear-cursor.nvim',
    opts = {
      smear_between_buffers = true,
      smear_between_neighbor_lines = true,
      scroll_buffer_space = true,
      legacy_computing_symbols_support = false,
      smear_insert_mode = true,
    },
  },
  { -- Indent guides on blank lines
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },
}
