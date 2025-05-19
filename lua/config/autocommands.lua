vim.api.nvim_create_autocmd('VimLeave', {
  callback = function()
    io.stdout:write '\027]111;;\027\\'
  end,
})
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    local bg = vim.api.nvim_get_hl(0, { name = 'Normal', link = false }).bg
    io.stdout:write(('\027]11;#%06x\027\\'):format(bg))
  end,
})
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
vim.api.nvim_create_augroup('RemoveTrailingWhitespace', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = 'RemoveTrailingWhitespace',
  pattern = '*',
  command = '%s/\\s\\+$//e',
})
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local pos = vim.api.nvim_buf_get_mark(0, '"')
    local last_line = vim.api.nvim_buf_line_count(0)
    if pos[1] > 0 and pos[1] <= last_line then
      pcall(vim.api.nvim_win_set_cursor, 0, pos)
    end
  end,
})
