-- ~/.config/nvim/LuaSnip/snippets/lua.lua

local ls = require 'luasnip'
local fmt = require('luasnip.extras.fmt').fmt
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s(
    'snippet_header',
    fmt(
      [[
local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node
local r = ls.restore_node
local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

{0}
  ]],
      { [0] = i(0) }
    )
  ),
}
