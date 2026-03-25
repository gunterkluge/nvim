return {
  {
    'saghen/blink.compat',
    version = '*',
    lazy = true,
    opts = {},
  },
  {
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          -- jsregexp Build braucht make (nicht auf Windows verfuegbar)
          if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        opts = {},
        config = function()
          require('luasnip.loaders.from_lua').load { paths = { vim.fn.stdpath 'config' .. '/LuaSnip' } }
          require('luasnip').config.set_config {
            enable_autosnippets = true,
          }
        end,
      },
      'folke/lazydev.nvim',
      'micangl/cmp-vimtex',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      -- <C-y> zum Akzeptieren (Tab kollidiert mit LuaSnip)
      keymap = { preset = 'default' },

      appearance = { nerd_font_variant = 'mono' },

      completion = {
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        per_filetype = {
          tex = { 'vimtex', 'snippets' },
          org = { 'orgmode', 'snippets', 'path' },
          sql = { 'dadbod', 'snippets', 'path' },
          mysql = { 'dadbod', 'snippets', 'path' },
          plsql = { 'dadbod', 'snippets', 'path' },
        },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
          vimtex = { name = 'vimtex', module = 'blink.compat.source' },
          dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
          orgmode = { name = 'Orgmode', module = 'orgmode.org.autocompletion.blink' },
        },
      },

      snippets = { preset = 'luasnip' },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
      signature = { enabled = true },
    },
  },
}
