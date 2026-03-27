-- Ersetzt die *** Sternchen durch huebsche Unicode-Zeichen
return {
  'nvim-orgmode/org-bullets.nvim',
  ft = { 'org' },
  opts = {
    concealcursor = false,
    symbols = {
      headlines = { '◉', '○', '✸', '✿' },
    },
  },
}
