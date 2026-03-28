-- vim-table-mode: Tabellen live formatieren beim Tippen
-- In org-Dateien: | tippen und Tab druecken richtet automatisch aus
return {
  'dhruvasagar/vim-table-mode',
  ft = { 'org', 'markdown' },
  init = function()
    -- Org-Tabellen nutzen | als Trennzeichen (nicht +)
    vim.g.table_mode_corner = '|'
    -- Automatisch aktivieren in org-Dateien
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'org', 'markdown' },
      callback = function()
        vim.cmd('TableModeEnable')
      end,
    })
  end,
}
