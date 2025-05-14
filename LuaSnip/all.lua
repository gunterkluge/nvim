local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
return {
  --A snippet that expands the trigger "hi" into the string "Hello, world!".
  s({ trig = 'hi' }, { t 'Hello, world!' }),
  -- To return multiple snippets, use one 'return' statement per snippet
  -- and return a table of Lua snippets.
  s({
    trig = 'mfg',
    snippetType = 'autosnippet',
  }, { t { 'Mit freundlichen Grüßen', 'Gunter Kluge' } }),
}
