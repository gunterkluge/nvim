-- Telescope-Extension fuer Orgmode: Fuzzy-Suche ueber Headlines, Refile, Links
return {
  'nvim-orgmode/telescope-orgmode.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-orgmode/orgmode',
  },
  ft = { 'org' },
  config = function()
    require('telescope').load_extension('orgmode')

    vim.keymap.set('n', '<leader>so', function()
      require('telescope').extensions.orgmode.search_headings()
    end, { desc = 'Search Org Headlines' })

    vim.keymap.set('n', '<leader>si', function()
      require('telescope').extensions.orgmode.insert_link()
    end, { desc = 'Insert Org Link' })

    vim.keymap.set('n', '<leader>sO', function()
      require('telescope').extensions.orgmode.refile_heading()
    end, { desc = 'Refile Org Heading (Telescope)' })
  end,
}
