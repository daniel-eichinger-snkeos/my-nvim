return {
  { -- Autoformat on save
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = true,
      format_on_save = function(bufnr)
        -- Disable format_on_save for languages without a standardized style
        local disable_filetypes = { c = true, cpp = true, hcl = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 3000,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters = {
        powershell_es = {
          command = 'pwsh',
          args = {
            '-NoProfile',
            '-Command',
            '[Console]::In.ReadToEnd() | Invoke-Formatter | Out-String | %{ ($_.TrimEnd("`r", "`n")) + "`r`n" }',
          },
          stdin = true,
        },
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        hcl = { 'hcl' },
        ps1 = { 'powershell_es' },
      },
    },
  },
}
