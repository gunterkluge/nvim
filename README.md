# Neovim Config

Plattformuebergreifende Neovim-Konfiguration (macOS, Windows, Linux).

## Installation

### Voraussetzungen (alle Plattformen)

- **Neovim >= 0.10**
- **Git**
- **Node.js** (fuer einige LSP-Server via Mason)
- **Nerd Font** (z.B. JetBrainsMono Nerd Font)

### macOS

```bash
# Config klonen
git clone <repo-url> ~/.config/nvim

# Neovim starten — Plugins installieren sich automatisch via lazy.nvim
nvim
```

### Windows

```powershell
# Config klonen
git clone <repo-url> $env:LOCALAPPDATA\nvim

# Neovim starten
nvim
```

### Zusaetzliche Abhaengigkeiten Windows

| Tool | Wofuer | Installation |
|------|--------|-------------|
| **Zig** | Treesitter-Parser kompilieren (kein gcc/clang noetig) | `winget install zig.zig` oder [ziglang.org](https://ziglang.org/download/) |
| **Git for Windows** | Org-Sync (nutzt Git Bash fuer Shell-Befehle) | `winget install Git.Git` |
| **CMake** | telescope-fzf-native bauen | `winget install Kitware.CMake` |
| **make** (optional) | LuaSnip jsregexp (wird auf Windows uebersprungen wenn nicht vorhanden) | via MinGW oder Build Tools |

### Zusaetzliche Abhaengigkeiten macOS

| Tool | Wofuer | Installation |
|------|--------|-------------|
| **make** | telescope-fzf-native, LuaSnip jsregexp | Xcode CLT: `xcode-select --install` |

## Fehlerbehebung

### Treesitter-Parser kompilieren nicht (Windows)

**Symptom:** Fehler wie `cc: not found` oder `No C compiler found` beim Start.

**Ursache:** Windows hat standardmaessig keinen C-Compiler. Die Config nutzt Zig als Fallback.

**Loesung:**
```powershell
winget install zig.zig
# Neovim neu starten, Parser werden automatisch gebaut
```

Falls Zig installiert ist aber nicht gefunden wird: sicherstellen dass `zig.exe` in `PATH` liegt.

### Org-Sync funktioniert nicht (Windows)

**Symptom:** Warnung `org-sync: Git Bash nicht gefunden`.

**Ursache:** Die Org-Synchronisation nutzt bash-Syntax und braucht auf Windows Git Bash.

**Loesung:**
1. Git for Windows installieren: `winget install Git.Git`
2. Pruefen ob `C:\Program Files\Git\bin\bash.exe` existiert
3. Falls Git woanders installiert ist: Pfad in `lua/config/autocommands.lua` anpassen (Variable `git_bash`)

### Colorscheme ist immer dunkel (Windows/Linux)

**Symptom:** Kein automatischer Wechsel zwischen Light und Dark Mode.

**Ursache:** Die automatische Erkennung nutzt `defaults read` (macOS-only). Auf Windows/Linux wird `mocha` (dark) als Fallback verwendet.

**Loesung:** Manuell umschalten mit `<leader>tl` (Toggle Light/Dark).

### telescope-fzf-native baut nicht (Windows)

**Symptom:** Fehler beim Build von `telescope-fzf-native.nvim`.

**Loesung:**
```powershell
winget install Kitware.CMake
# Neovim neu starten, Plugin wird automatisch neu gebaut
```

### LuaSnip-Snippets werden nicht geladen

**Symptom:** Eigene Snippets aus `LuaSnip/` sind nicht verfuegbar.

**Loesung:** Der Pfad wird automatisch ueber `vim.fn.stdpath('config')` ermittelt. Pruefen mit:
```vim
:echo stdpath('config')
```
Das sollte auf den Ordner zeigen, in dem `init.lua` liegt. Der Unterordner `LuaSnip/` muss dort existieren.

### Mason-LSP-Server installieren sich nicht

**Symptom:** `:Mason` zeigt Fehler bei der Installation.

**Loesung:**
- Node.js und npm muessen in `PATH` sein
- Auf Windows: PowerShell als Standard-Shell pruefen (`:echo &shell`)
- Einzelne Server manuell installieren: `:MasonInstall pyright`
