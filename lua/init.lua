vim.cmd 'echo "init.lua geladen"'
require 'config.options'
require 'config.keymaps'
require 'custom.journal'
require('custom.journal').helper()
