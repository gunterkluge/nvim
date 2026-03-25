-- Yank-Highlight
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Trailing Whitespace beim Speichern entfernen
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('remove-trailing-whitespace', { clear = true }),
  pattern = '*',
  command = '%s/\\s\\+$//e',
})

-- Cursor-Position wiederherstellen beim Oeffnen
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
-- Org Auto-Sync v3: Stash-safe, --no-rebase, asynchron
--   Windows: PowerShell (pwsh / powershell)
--   Unix:    bash
-- =============================================================

local org_dir = vim.fn.expand '~/org'

local function is_org_repo()
  return vim.fn.isdirectory(org_dir .. '/.git') == 1
end

-- Git-Befehl im org-Ordner ausfuehren mit Fehler-Notification
local function org_git(cmd, label)
  local shell
  if vim.fn.has('win32') == 1 then
    local ps = vim.fn.executable('pwsh') == 1 and 'pwsh' or 'powershell'
    shell = { ps, '-NoProfile', '-NonInteractive', '-Command', cmd }
  else
    shell = { 'bash', '-c', cmd }
  end

  vim.fn.jobstart(shell, {
    detach = true,
    on_stderr = function(_, data)
      if data and data[1] ~= '' then
        vim.schedule(function()
          vim.notify(label .. ': ' .. table.concat(data, '\n'), vim.log.levels.WARN)
        end)
      end
    end,
  })
end

-- Pull beim Neovim-Start: stasht erst, damit unstaged changes kein Problem sind
vim.api.nvim_create_autocmd('VimEnter', {
  group = vim.api.nvim_create_augroup('org-sync-pull', { clear = true }),
  callback = function()
    if not is_org_repo() then return end

    local cmd
    if vim.fn.has('win32') == 1 then
      cmd = table.concat({
        'cd ~/org',
        'git stash --include-untracked 2>$null',
        'git pull --no-rebase',
        'git stash pop 2>$null',
        'git add -A',
        'git diff --cached --quiet; if ($LASTEXITCODE -ne 0) { git commit -m "sync: auto-merge on startup" }',
      }, '; ')
    else
      cmd = table.concat({
        'cd ' .. org_dir,
        'git stash --include-untracked 2>/dev/null',
        'git pull --no-rebase',
        'git stash pop 2>/dev/null',
        'git add -A && git diff --cached --quiet || git commit -m "sync: auto-merge on startup"',
      }, ' && ')
    end

    org_git(cmd, 'org pull')
  end,
  desc = 'Pull org repo on Neovim start (stash-safe)',
})

-- Auto-Commit + Push bei jedem Speichern einer .org-Datei
vim.api.nvim_create_autocmd('BufWritePost', {
  group = vim.api.nvim_create_augroup('org-sync-push', { clear = true }),
  pattern = vim.fn.expand('~/org') .. '/*.org',
  callback = function()
    if not is_org_repo() then return end

    local filename = vim.fn.expand('%:t')
    local timestamp = os.date('%Y-%m-%d %H:%M')
    local commit_msg = string.format('update %s (%s)', filename, timestamp)

    local cmd
    if vim.fn.has('win32') == 1 then
      cmd = table.concat({
        'cd ~/org',
        'git add -A',
        string.format('git diff --cached --quiet; if ($LASTEXITCODE -ne 0) { git commit -m "%s" }', commit_msg),
        'git pull --no-rebase',
        'git push',
      }, '; ')
    else
      cmd = table.concat({
        'cd ' .. org_dir,
        'git add -A',
        string.format('git diff --cached --quiet || git commit -m "%s"', commit_msg),
        'git pull --no-rebase',
        'git push',
      }, ' && ')
    end

    org_git(cmd, 'org sync')
  end,
  desc = 'Auto-commit and push org files on save',
})
