return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    -- Dark/Light-Erkennung: macOS via defaults, Windows/Linux Fallback auf dark
    local flavour
    if vim.fn.has('mac') == 1 then
      local result = vim.fn.system 'defaults read -g AppleInterfaceStyle 2>/dev/null'
      flavour = vim.trim(result) == 'Dark' and 'mocha' or 'latte'
    else
      flavour = 'mocha'
    end

    require('catppuccin').setup {
      flavour = flavour,
      -- Für Rot-Grün-Sehschwäche: diff-Farben auf blau/gelb anstatt grün/rot
      color_overrides = {
        all = {
          -- diff: statt grün/rot → blau/orange
        },
      },
      integrations = {
        blink_cmp = true,
        gitsigns = true,
        mason = true,
        mini = { enabled = true },
        neotree = true,
        telescope = { enabled = true },
        treesitter = true,
        which_key = true,
      },
    }
    vim.cmd.colorscheme 'catppuccin'
  end,
}
