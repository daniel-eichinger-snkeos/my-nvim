return {
  'CopilotC-Nvim/CopilotChat.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim', branch = 'master' },
  },
  build = 'make',
  opts = {
    window = {
      layout = 'vertical',
      title = '🤖',
      zindex = 100,
    },

    headers = {
      user = '🐍 Daniel',
      assistant = '🤖 Copilot',
      tool = '🔧 Tool',
    },

    separator = '━━',
    auto_fold = true, -- Automatically folds non-assistant messages
  },
}
