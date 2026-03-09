vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('c', 'jk', '<Esc>')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('n', '<leader>j', function()
  require('custom.journal').open_journal_for_today()
end, { desc = 'Open Journal' })
vim.keymap.set('n', '<leader>tz', function() require('zen-mode').toggle() end, { desc = 'Toggle ZenMode' })
vim.keymap.set('n', '<leader>tc', function()
  vim.wo.conceallevel = (vim.wo.conceallevel == 0) and 2 or 0
end, { desc = 'Toggle conceal' })
vim.keymap.set('n', '<leader>tl', function()
  local flavour = require('catppuccin').options.flavour == 'latte' and 'mocha' or 'latte'
  require('catppuccin').setup { flavour = flavour }
  vim.cmd.colorscheme 'catppuccin'
end, { desc = 'Toggle light/dark mode' })
