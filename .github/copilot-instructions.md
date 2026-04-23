# Neovim Config — Copilot Instructions

Cross-platform Neovim configuration (macOS, Windows, Linux).

## Architecture

`init.lua` loads four modules in order:

```
config/lazy-bootstrap  → installs lazy.nvim, sets <leader>=Space, <localleader>=,
config/options         → vim.opt settings
config/keymaps         → global keymaps (not plugin-specific)
config/autocommands    → global autocmds (org-sync, cursor restore)
```

All plugins live in `lua/plugins/`, one file per plugin. lazy.nvim auto-imports all files from that directory. Filetype-specific settings go in `after/ftplugin/`. Custom LuaSnip snippets are in `LuaSnip/` (loaded from `vim.fn.stdpath('config') .. '/LuaSnip'`).

## Code Style

- **Indentation**: 2 spaces (Lua), enforced by stylua
- **Quotes**: `AutoPreferSingle`, parentheses on function calls omitted where possible (`call_parentheses = "None"`)
- **Line width**: 160 columns (`stylua.toml`)
- **Comments**: written in **German**
- Lint/format: `stylua .` (Lua), `ruff format` (Python)

## Key Conventions

### Plugin structure
Each plugin file returns a lazy.nvim spec table. Keep plugin-specific keymaps and autocmds inside the plugin's `config` function, not in `config/keymaps.lua`.

### LSP setup
Uses Neovim's **native** `vim.lsp.config()` + `vim.lsp.enable()` API (Neovim ≥ 0.11), **not** `nvim-lspconfig` setup wrappers. Active servers: `lua_ls`, `pyright`, `ruff`, `texlab`. Configured in `lua/plugins/lsp.lua` inside the mason `config` function.

### Completion (blink.cmp)
- Keymap preset `default` → `<C-y>` to accept. **Do not switch to Tab** — it conflicts with LuaSnip snippet expansion.
- Completion sources vary by filetype:
  - Default: `lsp`, `path`, `snippets`, `lazydev`
  - `org`: `orgmode`, `snippets`, `path`
  - `sql`/`mysql`/`plsql`: `dadbod`, `snippets`, `path`
  - `tex`/`latex`: **`vimtex` + `snippets` only** (no `lsp`) — texlab completions are disruptive

### Treesitter
- Highlight for `latex`/`tex` is **disabled** — vimtex owns syntax highlighting for those filetypes.
- On Windows, Zig is set as the C compiler for building parsers (`require('nvim-treesitter.install').compilers = { 'zig' }`).
- orgmode installs its Treesitter parser through its **own** installer (`orgmode.utils.treesitter.install`), independent of nvim-treesitter.

### Colorscheme
Two schemes available, toggled via keymaps:
- **Catppuccin** (default): `mocha` (dark) on macOS Dark Mode, `latte` (light) otherwise. Catppuccin latte has `peach` overridden to blue for red-green colorblindness.
- **Modus** (accessible alternative): `modus_operandi` (light) / `modus_vivendi` (dark).
- `<leader>tl` toggles dark/light within the active scheme; `<leader>ts` switches between Catppuccin and Modus.
- Color changes sync to WezTerm via OSC 1337 (`SetUserVar=THEME`).

### Formatting (conform.nvim)
Formats on save automatically. Formatters per filetype:
- `lua` → stylua
- `python` → ruff_format
- `markdown` → prettier (prose-wrap always, 80 cols)
- `sql` → sql_formatter (PostgreSQL dialect, uppercase keywords)
- `c`/`cpp` → **disabled** (no format-on-save)
- `*` → trim_whitespace

### Org-mode sync
`config/autocommands.lua` runs async git operations on the `~/org` directory:
- **VimEnter**: stash → pull → pop → commit if dirty
- **BufWritePost** (`*.org`): add → commit → pull → push

Shell commands are PowerShell-aware on Windows (`pwsh`/`powershell`) and `bash` on Unix.

## Decisions Not to Change Without Good Reason

| Setting | Value | Why |
|---------|-------|-----|
| `timeoutlen` | 349 ms | Tuned for Corne keyboard with Home Row Mods |
| `ttimeoutlen` | 10 ms | Fast Escape response |
| blink.cmp accept key | `<C-y>` | Tab conflicts with LuaSnip |
| tex completion sources | vimtex + snippets | texlab completions are noisy |
| Treesitter latex highlight | disabled | vimtex handles it |

## Windows-Specific Notes

- Zig required for building Treesitter parsers: `winget install zig.zig`
- CMake required for telescope-fzf-native: `winget install Kitware.CMake`
- LuaSnip jsregexp build is skipped on Windows (no `make`)
- Locale is set to German time format via `os.setlocale('german', 'time')`
