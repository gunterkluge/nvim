return {
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer' },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.dbs = {
        { name = 'controlling', url = vim.env.DATABASE_URL or 'postgresql://postgres@localhost:5432/controlling' },
      }
      vim.g.db_ui_save_location = vim.fn.expand '~/copilot/lernprojekt/queries/'
    end,
  },
}
