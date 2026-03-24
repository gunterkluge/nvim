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
  group = vim.api.nvim_create_augroup('restore-cursor', { clear = true }),
  callback = function()
    local pos = vim.api.nvim_buf_get_mark(0, '"')
    local last_line = vim.api.nvim_buf_line_count(0)
    if pos[1] > 0 and pos[1] <= last_line then
      pcall(vim.api.nvim_win_set_cursor, 0, pos)
    end
  end,
})
-- =============================================================
-- Org Auto-Sync: Auto-Commit + Push bei jedem :w
-- Einfuegen in: ~/.config/nvim/lua/config/autocommands.lua
-- =============================================================

-- Pull beim Neovim-Start (holt Aenderungen vom anderen Rechner)
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    local org_dir = vim.fn.expand '~' .. '/org'
    -- Nur wenn ~/org existiert und ein Git-Repo ist
    if vim.fn.isdirectory(org_dir .. '/.git') == 1 then
      vim.fn.jobstart({ 'git', '-C', org_dir, 'pull', '--rebase' }, {
        detach = true,
        on_stderr = function(_, data)
          if data and data[1] ~= '' then
            vim.schedule(function()
              vim.notify('org pull: ' .. table.concat(data, '\n'), vim.log.levels.WARN)
            end)
          end
        end,
      })
    end
  end,
  desc = 'Pull org repo on Neovim start',
})

-- Auto-Commit + Push bei jedem Speichern einer .org-Datei in ~/org/
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = vim.fn.expand '~' .. '/org/*.org',
  callback = function()
    local org_dir = vim.fn.expand '~' .. '/org'
    local filename = vim.fn.expand '%:t' -- z.B. "baustellen.org"
    local timestamp = os.date '%Y-%m-%d %H:%M' -- z.B. "2026-03-24 14:32"
    local commit_msg = string.format('update %s (%s)', filename, timestamp)

    -- git add + commit (nur wenn es Aenderungen gibt) + pull --rebase + push
    local cmd = string.format('cd %s && git add -A && git diff --cached --quiet || (git commit -m "%s" && git pull --rebase && git push)', org_dir, commit_msg)

    vim.fn.jobstart({ 'bash', '-c', cmd }, {
      detach = true,
      on_stderr = function(_, data)
        if data and data[1] ~= '' then
          vim.schedule(function()
            vim.notify('org sync: ' .. table.concat(data, '\n'), vim.log.levels.WARN)
          end)
        end
      end,
    })
  end,
  desc = 'Auto-commit and push org files on save',
})
