vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('c', 'jk', '<Esc>')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('n', '<leader>tz', function() require('zen-mode').toggle() end, { desc = 'Toggle ZenMode' })
vim.keymap.set('n', '<leader>tc', function()
  vim.wo.conceallevel = (vim.wo.conceallevel == 0) and 2 or 0
end, { desc = 'Toggle conceal' })
-- Hilfsfunktion: WezTerm-Theme per OSC 1337 synchronisieren
local function sync_wezterm(scheme)
  io.write(string.format('\027]1337;SetUserVar=THEME=%s\a', vim.base64.encode(scheme)))
end

-- Aktuelles Farbschema merken (catppuccin oder modus)
vim.g.current_scheme = vim.g.current_scheme or 'catppuccin'

-- <leader>tl — Light/Dark umschalten (innerhalb des aktiven Schemas)
vim.keymap.set('n', '<leader>tl', function()
  if vim.g.current_scheme == 'catppuccin' then
    local flavour = require('catppuccin').options.flavour == 'latte' and 'mocha' or 'latte'
    require('catppuccin').setup { flavour = flavour }
    vim.cmd.colorscheme 'catppuccin'
    sync_wezterm(flavour == 'latte' and 'light' or 'dark')
  else
    -- Modus: zwischen light und dark wechseln ueber vim.o.background
    if vim.o.background == 'light' then
      vim.o.background = 'dark'
      vim.cmd.colorscheme 'modus_vivendi'
      sync_wezterm('modus-dark')
    else
      vim.o.background = 'light'
      vim.cmd.colorscheme 'modus_operandi'
      sync_wezterm('modus-light')
    end
  end
end, { desc = 'Toggle light/dark mode' })

-- <leader>ts — Schema wechseln: Catppuccin <-> Modus
vim.keymap.set('n', '<leader>ts', function()
  if vim.g.current_scheme == 'catppuccin' then
    vim.g.current_scheme = 'modus'
    vim.o.background = 'light'
    vim.cmd.colorscheme 'modus_operandi'
    sync_wezterm('modus-light')
    vim.notify('Modus Operandi (Deuteranopia)', vim.log.levels.INFO)
  else
    vim.g.current_scheme = 'catppuccin'
    require('catppuccin').setup { flavour = 'latte' }
    vim.cmd.colorscheme 'catppuccin'
    sync_wezterm('light')
    vim.notify('Catppuccin Latte', vim.log.levels.INFO)
  end
end, { desc = 'Switch scheme (Catppuccin/Modus)' })
