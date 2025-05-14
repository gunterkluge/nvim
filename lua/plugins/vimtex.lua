return {
  'lervag/vimtex',
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = 'skim'
    vim.g.vimtex_fold_enabled = true
    -- vim.g.vimtex_mappings_override_existing = true
    vim.g.vimtex_syntax_conceal = {
      accents = 1,
      ligatures = 1,
      cites = 1,
      fancy = 1,
      math_bounds = 1,
      math_delimiters = 1,
      math_fracs = 1,
      math_symbols = 1,
      sections = 1,
      styles = 1,
    }
  end,
}
