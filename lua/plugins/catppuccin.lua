return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    -- Dark/Light-Erkennung: macOS via defaults, Windows/Linux Fallback auf dark
    local flavour
    if vim.fn.has 'mac' == 1 then
      local result = vim.fn.system 'defaults read -g AppleInterfaceStyle 2>/dev/null'
      flavour = vim.trim(result) == 'Dark' and 'mocha' or 'latte'
    else
      flavour = 'latte'
    end

    require('catppuccin').setup {
      flavour = flavour,
      color_overrides = {
        latte = {
          -- Peach/Orange durch Blau ersetzen (Rot-Gruen-freundlich)
          peach = '#1e66f5', -- war orange, jetzt blau (wie Latte blue)
        },
      },
      custom_highlights = function(colors)
        return {
          -- Org-Ueberschriften: kein grauer Hintergrund, klare Farben
          ['@org.headline.level1'] = { fg = colors.blue, bold = true, bg = 'NONE' },
          ['@org.headline.level2'] = { fg = colors.sapphire, bold = true, bg = 'NONE' },
          ['@org.headline.level3'] = { fg = colors.teal, bg = 'NONE' },
          ['@org.headline.level4'] = { fg = colors.sky, bg = 'NONE' },
          ['@org.headline.level5'] = { fg = colors.lavender, bg = 'NONE' },
          ['@org.headline.level6'] = { fg = colors.blue, bg = 'NONE' },
          ['@org.headline.level7'] = { fg = colors.sapphire, bg = 'NONE' },
          ['@org.headline.level8'] = { fg = colors.teal, bg = 'NONE' },
          -- Die Gruppen auf die headline.level* verlinkt sind — auch aufraeumen
          Title = { fg = colors.blue, bold = true, bg = 'NONE' },
          -- Eingeklappte Zeilen: kein grauer Hintergrund
          Folded = { fg = colors.overlay1, bg = 'NONE' },
          -- Org-TODO/DONE: blau/teal statt rot/gruen
          ['@org.keyword.todo'] = { fg = colors.blue, bold = true, bg = 'NONE' },
          ['@org.keyword.done'] = { fg = colors.teal, bold = true, bg = 'NONE' },
          -- Org-Tags und Timestamps lesbar halten
          ['@org.tag'] = { fg = colors.mauve },
          ['@org.plan'] = { fg = colors.sapphire },
          ['@org.timestamp.active'] = { fg = colors.sapphire },
          ['@org.timestamp.inactive'] = { fg = colors.overlay1 },
          -- Org-Bullets und Sterne
          ['@org.bullet'] = { fg = colors.blue },
          -- Org-Properties/Drawer dezent
          ['@org.properties'] = { fg = colors.overlay0 },
          ['@org.drawer'] = { fg = colors.overlay0 },
          ['@org.directive'] = { fg = colors.overlay1 },
          -- Prioritaeten: blau-Spektrum statt rot/gruen
          ['@org.priority.highest'] = { fg = colors.blue, bold = true },
          ['@org.priority.high'] = { fg = colors.sapphire, bold = true },
          ['@org.priority.default'] = { fg = colors.teal },
          ['@org.priority.low'] = { fg = colors.overlay1 },
          ['@org.priority.lowest'] = { fg = colors.overlay0 },
          -- Checkboxen
          ['@org.checkbox'] = { fg = colors.blue },
          ['@org.checkbox.checked'] = { fg = colors.teal },
          ['@org.checkbox.halfchecked'] = { fg = colors.sapphire },
        }
      end,
      integrations = {
        blink_cmp = true,
        gitsigns = true,
        mason = true,
        mini = { enabled = true },
        neotree = true,
        telescope = { enabled = true },
        treesitter = true,
        which_key = true,
      },
    }
    vim.cmd.colorscheme 'catppuccin'

    -- Org-Highlights NACH dem Colorscheme nochmal erzwingen,
    -- weil Treesitter-Links die custom_highlights ueberschreiben koennen
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'org',
      callback = function()
        local c = require('catppuccin.palettes').get_palette()
        local hi = vim.api.nvim_set_hl
        for i = 1, 8 do
          local fg_cycle = { c.blue, c.sapphire, c.teal, c.sky, c.lavender, c.blue, c.sapphire, c.teal }
          hi(0, '@org.headline.level' .. i, { fg = fg_cycle[i], bold = i <= 2, bg = 'NONE' })
        end
        hi(0, '@org.keyword.todo', { fg = c.blue, bold = true, bg = 'NONE' })
        hi(0, '@org.keyword.done', { fg = c.teal, bold = true, bg = 'NONE' })
      end,
    })
  end,
}
