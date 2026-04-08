return { -- Autoformat
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
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Nicht-modifizierbare Buffer (z.B. checkhealth) ueberspringen
      if not vim.bo[bufnr].modifiable then
        return nil
      end
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 1500,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'ruff_format' },
      markdown = { 'prettier' },
      sql = { 'sql_formatter' },
      ['*'] = { 'trim_whitespace' },
    },
    formatters = {
      prettier = {
        prepend_args = { '--prose-wrap', 'always', '--print-width', '80' },
      },
      sql_formatter = {
        prepend_args = { '--language', 'postgresql', '--config', '{"keywordCase":"upper"}' },
      },
    },
  },
}
