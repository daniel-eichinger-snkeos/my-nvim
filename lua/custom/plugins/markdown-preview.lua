-- Use :MarkdownPreview to spawn a preview in the browser
return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  build = 'npm install', -- had to run this manually in ~\AppData\Local\nvim-data\lazy\markdown-preview.nvim; https://github.com/iamcco/markdown-preview.nvim/issues/695
  init = function()
    vim.g.mkdp_filetypes = { 'markdown' }
  end,
  ft = { 'markdown' },
}
