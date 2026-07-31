-- [[ Basic Keymaps ]]
-- See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Save current buffer
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', { desc = 'Save current buffer' })

-- Paste over selected text without yanking
vim.keymap.set('x', '<leader>p', [["_dP]])

-- Strip \r (^M) from clipboard register before pasting (fixes Windows line endings)
local function clean_paste(cmd)
  return function()
    local reg = vim.fn.getreg '+'
    if reg:find('\r', 1, true) then
      local regtype = vim.fn.getregtype '+'
      vim.fn.setreg('+', reg:gsub('\r', ''), regtype)
    end
    return cmd
  end
end
vim.keymap.set('n', 'p', clean_paste 'p', { expr = true, noremap = true, desc = 'Paste (strip ^M)' })
vim.keymap.set('n', 'P', clean_paste 'P', { expr = true, noremap = true, desc = 'Paste before (strip ^M)' })

-- Diagnostic quickfix list
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- LSP hover with border
vim.keymap.set('n', 'gh', function()
  vim.lsp.buf.hover { border = 'single', max_height = 25, max_width = 120 }
end, { desc = 'Show hover docs' })

-- Exit terminal mode more easily
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Split navigation with CTRL+<hjkl>
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Oil file explorer
vim.keymap.set('n', '-', '<cmd>Oil<CR>', { desc = 'Open Oil file explorer' })

-- Close / quit current buffer
vim.keymap.set({ 'n', 't' }, '<leader>q', ':bd<cr>', { silent = true, noremap = true, desc = 'Quit current buffer' })

-- Format buffer with jq
vim.keymap.set('n', '<leader>j', function()
  vim.cmd "%!jq '.'"
end, { desc = 'Format buffer with jq' })

-- CodeCompanion AI keymaps
vim.keymap.set({ 'n', 'v' }, '<LocalLeader>ac', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true, desc = '[A]I [C]hat' })
vim.keymap.set({ 'n', 'v' }, '<LocalLeader>ai', '<cmd>CodeCompanion<cr>', { noremap = true, silent = true, desc = '[A]I [I]nline' })
