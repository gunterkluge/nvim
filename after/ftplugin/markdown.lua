-- Erkennung von Codeblöcken für bestimmte Sprachen
vim.g.markdown_fenced_languages = {
  'bash=sh',
  'python',
  'lua',
}

-- Falten von Überschriften in Markdown-Dateien
vim.g.markdown_folding = 1

vim.opt_local.wrap = true
vim.opt_local.textwidth = 78
vim.opt_local.colorcolumn = '80'
vim.opt_local.linebreak = true

vim.opt_local.spell = true
vim.opt_local.spelllang = 'de_de'
vim.opt_local.conceallevel = 2
vim.opt_local.foldenable = false

-- Verhindert automatische Kommentare bei 'o' oder Enter
vim.opt_local.formatoptions:remove 'o'
vim.opt_local.formatoptions:remove 'r'

-- Optionale Ergänzungen:
-- Automatischer Zeilenumbruch im Editor anzeigen

-- Optional: autoindent behalten, aber smartindent und co. abschalten, wenn's stört
-- vim.opt_local.autoindent = true
-- vim.opt_local.smartindent = false
vim.opt_local.expandtab = true -- Verwenden von Leerzeichen anstelle von Tabulatoren
vim.opt_local.shiftwidth = 2 -- 2 Leerzeichen pro Tab
vim.opt_local.softtabstop = 2 -- Wechselt nach 2 Zeichen für die Tabulatorverwendung
vim.opt_local.autoindent = true -- Aktiviert die automatische Einrückung
vim.opt_local.smartindent = true -- Aktiviert intelligente Einrückung
-- vim.cmd.colorscheme 'rose-pine-dawn'
