-- [[ Autocommands ]]
-- See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Disable relative numbers in Copilot chat buffers
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = 'copilot-*',
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = true
  end,
})

-- Terminal keymaps: easier escape and window switching
local function set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = 'term://*',
  callback = set_terminal_keymaps,
})

-- Enable treesitter highlighting for specific filetypes
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'go', 'terraform', 'gomod', 'lua', 'csharp', 'http' },
  callback = function()
    vim.treesitter.start()
  end,
})

-- Open help in a vertical split
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'help',
  command = 'wincmd L',
})

-- Syntax highlighting for *.hcl.tpl files
vim.api.nvim_create_autocmd('BufRead', {
  group = vim.api.nvim_create_augroup('hcl_tpl_ft', { clear = true }),
  pattern = '*.hcl.tpl',
  callback = function()
    vim.bo.filetype = 'hcl'
  end,
})

-- CodeCompanion spinner (based on https://github.com/olimorris/dotfiles)
local spinner = {
  completed = '󰗡 Completed',
  error = ' Error',
  cancelled = '󰜺 Cancelled',
}

---Format the adapter name and model for display with the spinner
---@param adapter CodeCompanion.Adapter
---@return string
local function format_adapter(adapter)
  local parts = {}
  table.insert(parts, adapter.formatted_name)
  if adapter.model and adapter.model ~= '' then
    table.insert(parts, '(' .. adapter.model .. ')')
  end
  return table.concat(parts, ' ')
end

local ok, progress = pcall(require, 'fidget.progress')
if ok then
  spinner.handles = {}
  local group = vim.api.nvim_create_augroup('dotfiles.codecompanion.spinner', {})

  vim.api.nvim_create_autocmd('User', {
    pattern = 'CodeCompanionRequestStarted',
    group = group,
    callback = function(args)
      local handle = progress.handle.create {
        title = '',
        message = '  Sending...',
        lsp_client = {
          name = format_adapter(args.data.adapter),
        },
      }
      spinner.handles[args.data.id] = handle
    end,
  })

  vim.api.nvim_create_autocmd('User', {
    pattern = 'CodeCompanionRequestFinished',
    group = group,
    callback = function(args)
      local handle = spinner.handles[args.data.id]
      spinner.handles[args.data.id] = nil
      if handle then
        if args.data.status == 'success' then
          handle.message = spinner.completed
        elseif args.data.status == 'error' then
          handle.message = spinner.error
        else
          handle.message = spinner.cancelled
        end
        handle:finish()
      end
    end,
  })
end
