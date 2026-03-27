# Neovim Config

## Struktur
- `lua/config/` — options, keymaps, autocommands, lazy-bootstrap
- `lua/plugins/` — je Plugin eine Datei
- `after/ftplugin/` — dateityp-spezifische Einstellungen
- `LuaSnip/` — eigene Snippets nach Dateityp

## Plugin-Stack
- **Paketmanager**: lazy.nvim
- **Completion**: blink.cmp + LuaSnip (eigene Snippets in `LuaSnip/`)
- **LSP**: nvim-lspconfig + Mason (pyright, ruff, texlab, lua_ls)
- **Formatter**: conform.nvim (stylua für Lua, ruff_format für Python)
- **Fuzzy Finder**: Telescope
- **Colorscheme**: Catppuccin (mocha=dark, latte=light, folgt macOS Appearance)
- **Dateibaum**: Neo-tree
- **Fokus**: zen-mode + twilight
- **LaTeX**: vimtex (Viewer: Skim)

## Konventionen
- Einrückung: 2 Leerzeichen (Lua)
- Stil wird durch stylua erzwungen (`stylua.toml` vorhanden)
- Kommentare im Code auf **Deutsch**
- Eine Datei pro Plugin in `lua/plugins/`

## Wichtige Entscheidungen (nicht ändern ohne Grund)
- `timeoutlen = 349` — abgestimmt auf Corne-Tastatur mit Home Row Mods
- `ttimeoutlen = 10` — bewusst kurz für schnelle Escape-Reaktion
- blink.cmp keymap preset `default` (`<C-y>` zum Akzeptieren) — Tab kollidiert mit LuaSnip
- tex-Dateien: nur `vimtex` + `snippets` als Completion-Sources (kein lsp), da texlab-Completions stören
- Treesitter highlight für latex/tex deaktiviert — vimtex übernimmt das

## Tastenkürzel (eigene)
- `<leader>oc` → `j` — Journal-Eintrag (Org Capture)
- `<leader>tl` — Light/Dark toggle
- `<leader>tz` — Zen-Mode toggle
- `<leader>tc` — Conceal toggle
- `<leader>th` — Inlay Hints toggle
- `jk` — Escape (Insert + Command Mode)
