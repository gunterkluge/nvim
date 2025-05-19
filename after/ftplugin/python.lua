-- make und errorformat einrichten
vim.opt_local.makeprg = 'python3 %'
vim.opt_local.errorformat = [[%E  File "%f", line %l, %m,%-Z%p^,%-G%.%#]]

-- Keymap für :make + Quickfix öffnen
vim.keymap.set('n', '<leader>m', function()
  vim.cmd 'make'
end, { buffer = true, desc = 'Python: make' })

-- Optional: Quickfix mit Telescope anzeigen
vim.keymap.set('n', '<leader>q', function()
  require('telescope.builtin').quickfix()
end, { buffer = true, desc = 'Quickfix via Telescope' })
