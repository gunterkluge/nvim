-- vim-table-mode: Tabellen live formatieren beim Tippen
-- In org-Dateien: | tippen und Tab druecken richtet automatisch aus
return {
  'dhruvasagar/vim-table-mode',
  ft = { 'markdown' },
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'markdown' },
      callback = function()
        vim.cmd('silent TableModeEnable')
      end,
    })
  end,
}
