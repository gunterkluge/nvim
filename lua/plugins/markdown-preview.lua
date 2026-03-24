return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  ft = 'markdown',
  -- Vorkompilierte Binary statt npm install (laeuft auf Mac + Windows ohne Node)
  build = function(plugin)
    vim.cmd('source ' .. plugin.dir .. '/autoload/mkdp/util.vim')
    vim.fn['mkdp#util#install']()
  end,
  keys = {
    { '<leader>mp', '<cmd>MarkdownPreviewToggle<CR>', desc = 'Markdown Preview toggle' },
  },
}
