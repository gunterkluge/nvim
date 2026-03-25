local M = {}

if vim.g.journal_directory == nil then
  vim.g.journal_directory = vim.fn.expand '~/.journal'
end

local journal_dir = vim.g.journal_directory
local journal_info = {}

local sep = vim.fn.has('win32') == 1 and '\\' or '/'

local function calculate_journal_info(date)
  date = date or os.date '*t'
  journal_info.dir = string.format('%s' .. sep .. '%d' .. sep .. '%02d', journal_dir, date.year, date.month)
  journal_info.file_name = string.format('%s' .. sep .. '%02d.md', journal_info.dir, date.day)
  journal_info.day = string.format('%02d', date.day)
end

-- interne Funktion: erzeugt Verzeichnis und Datei, falls nicht vorhanden
local function create_journal_if_needed()
  if vim.fn.isdirectory(journal_info.dir) == 0 then
    vim.fn.mkdir(journal_info.dir, 'p')
  end
  local file = io.open(journal_info.file_name, 'r')
  if not file then
    file = io.open(journal_info.file_name, 'w')
    if file then
      file:close()
    end
  else
    file:close()
  end
end

M.create_journal_create_name = function(date)
  calculate_journal_info(date)
  return journal_info.dir, journal_info.file_name, journal_info.day
end

-- einzig öffentlicher Einstiegspunkt zum Öffnen (inkl. Erzeugen bei Bedarf)
M.open_journal_for_today = function(date)
  calculate_journal_info(date)
  create_journal_if_needed()
  -- Prüfen, ob die Datei schon offen ist
  local bufnr = vim.fn.bufnr(journal_info.file_name)
  if bufnr ~= -1 then
    vim.cmd('buffer ' .. bufnr) -- wechsle zu diesem Buffer
  else
    vim.cmd('edit ' .. journal_info.file_name) -- öffne die Datei
  end
end

return M
