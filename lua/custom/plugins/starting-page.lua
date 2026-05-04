return {
  'folke/snacks.nvim',
  ---@type snacks.Config
  opts = {
    dashboard = {
      preset = {
        header_hl = 'SnacksDashboardHeader',
        pick = function(cmd, opts)
          return LazyVim.pick(cmd, opts)()
        end,
        header = [[
 ███████╗███╗   ██╗ █████╗ ██╗  ██╗███████╗
 ██╔════╝████╗  ██║██╔══██╗██║ ██╔╝██╔════╝
 ███████╗██╔██╗ ██║███████║█████╔╝ █████╗  
 ╚════██║██║╚██╗██║██╔══██║██╔═██╗ ██╔══╝  
 ███████║██║ ╚████║██║  ██║██║  ██╗███████╗
 ╚══════╝╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝
]],

       -- stylua: ignore
       ---@type snacks.dashboard.Item[]
       keys = {
         { icon = " ", key = "f", desc = "Find File", action = ":lua require('telescope.builtin').find_files({hidden = true})" },
         { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
         { icon = " ", key = "g", desc = "Find Text", action = ":lua require('telescope.builtin').live_grep({hidden = true})" },
         { icon = " ", key = "c", desc = "Config", action = ":lua require('telescope.builtin').find_files({ cwd = vim.fn.stdpath 'config' })" },
         { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
         { icon = " ", key = "q", desc = "Quit", action = ":qa" },
       },
      },
    },
  },
}
