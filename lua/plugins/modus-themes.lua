-- Modus Themes: WCAG AAA Barrierefreiheit, mit Deuteranopie-Variante
-- Umschalten zwischen Catppuccin und Modus mit <leader>ts
return {
  'miikanissi/modus-themes.nvim',
  lazy = false,
  priority = 900, -- unter Catppuccin (1000), damit Catppuccin default bleibt
  config = function()
    require('modus-themes').setup({
      style = 'auto', -- folgt vim.o.background
      variant = 'deuteranopia', -- Rot-Gruen-freundlich
      on_highlights = function(highlights, colors)
        highlights['Folded'] = { fg = colors.fg_dim, bg = 'NONE' }
      end,
    })
    -- Nicht aktivieren — Catppuccin bleibt default, Modus per <leader>ts
  end,
}
