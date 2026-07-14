-- Use new UI added in neovim 0.12
-- run command w/ :!pwd and use g< ; use :q or ZZ to close it
require('vim._core.ui2').enable {}

-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

-- Set <space> as the leader key
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Disable GitHub Copilot auto suggestions by default (used via CodeCompanion)
vim.g.copilot_enabled = false
vim.g.copilot_version = false

-- Windows shell config
if vim.fn.has 'win32' == 1 then
  vim.opt.shell = '"C:/Program Files/Git/bin/bash.exe"'
  vim.opt.shellcmdflag = '-c'
  vim.opt.shellquote = ''
  vim.opt.shellxquote = ''
end

vim.o.wrap = false -- prevent lines from wrapping
vim.opt.tabstop = 4 -- display width of a tab character
vim.o.breakindent = true -- enable break indent

-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
-- Schedule after `UiEnter` to avoid increasing startup time.
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital letters in search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 600

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Whitespace character display
vim.o.list = false
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = false

-- Minimal number of screen lines to keep above and below the cursor
vim.o.scrolloff = 10

-- Raise a dialog when an operation would fail due to unsaved changes
vim.o.confirm = true

-- Auto-reload files changed outside nvim
vim.o.autoread = true
