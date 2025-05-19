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

return {
  -- Umgebungen
  s(
    {
      trig = 'eq',
      desc = '\\begin{equation}',
      snippetType = 'autosnippet',
    },
    fmt(
      [[
      \begin{equation}
        <>
      \end{equation}
      ]],
      { i(1) },
      {
        delimiters = '<>',
      }
    )
  ),
  -- Griechische Buchstaben
  s({
    trig = ';a',
    desc = '\\alpha',
    snippetType = 'autosnippet',
  }, { t '\\alpha' }),

  s({
    trig = ';b',
    desc = '\\beta',
    snippetType = 'autosnippet',
  }, { t '\\beta' }),
  s({
    trig = ';c',
    desc = '\\chi',
    snippetType = 'autosnippet',
  }, { t '\\chi' }),
  s({
    trig = ';d',
    desc = '\\delta',
    snippetType = 'autosnippet',
  }, { t '\\delta' }),
  s({
    trig = ';e',
    desc = '\\epsilon',
    snippetType = 'autosnippet',
  }, { t '\\epsilon' }),
  s({
    trig = ';f',
    desc = '\\phi',
    snippetType = 'autosnippet',
  }, { t '\\phi' }),
  s({
    trig = ';g',
    desc = '\\gamma',
    snippetType = 'autosnippet',
  }, { t '\\gamma' }),
  s({
    trig = ';h',
    desc = '\\eta',
    snippetType = 'autosnippet',
  }, { t '\\eta' }),
  s({
    trig = ';i',
    desc = '\\iota',
    snippetType = 'autosnippet',
  }, { t '\\iota' }),
  s({
    trig = ';k',
    desc = '\\kappa',
    snippetType = 'autosnippet',
  }, { t '\\kappa' }),
  s({
    trig = ';l',
    desc = '\\lambda',
    snippetType = 'autosnippet',
  }, { t '\\lambda' }),
  s({
    trig = ';m',
    desc = '\\mu',
    snippetType = 'autosnippet',
  }, { t '\\mu' }),
  s({
    trig = ';n',
    desc = '\\nu',
    snippetType = 'autosnippet',
  }, { t '\\nu' }),
  s({
    trig = ';p',
    desc = '\\pi',
    snippetType = 'autosnippet',
  }, { t '\\pi' }),
  s({
    trig = ';q',
    desc = '\\theta',
    snippetType = 'autosnippet',
  }, { t '\\theta' }),
  s({
    trig = ';r',
    desc = '\\rho',
    snippetType = 'autosnippet',
  }, { t '\\rho' }),
  s({
    trig = ';s',
    desc = '\\sigma',
    snippetType = 'autosnippet',
  }, { t '\\sigma' }),
  s({
    trig = ';t',
    desc = '\\tau',
    snippetType = 'autosnippet',
  }, { t '\\tau' }),
  s({
    trig = ';y',
    desc = '\\psi',
    snippetType = 'autosnippet',
  }, { t '\\psi' }),
  s({
    trig = ';u',
    desc = '\\upsilon',
    snippetType = 'autosnippet',
  }, { t '\\upsilon' }),
  s({
    trig = ';w',
    desc = '\\omega',
    snippetType = 'autosnippet',
  }, { t '\\omega' }),
  s({
    trig = ';z',
    desc = '\\zeta',
    snippetType = 'autosnippet',
  }, { t '\\zeta' }),
  s({
    trig = ';x',
    desc = '\\xi',
    snippetType = 'autosnippet',
  }, { t '\\xi' }),
  s({
    trig = ';D',
    desc = '\\Delta',
    snippetType = 'autosnippet',
  }, { t '\\Delta' }),
  s({
    trig = ';F',
    desc = '\\Phi',
    snippetType = 'autosnippet',
  }, { t '\\Phi' }),
  s({
    trig = ';G',
    desc = '\\Gamma',
    snippetType = 'autosnippet',
  }, { t '\\Gamma' }),
  s({
    trig = ';L',
    desc = '\\Lambda',
    snippetType = 'autosnippet',
  }, { t '\\Lambda' }),
  s({
    trig = ';P',
    desc = '\\Pi',
    snippetType = 'autosnippet',
  }, { t '\\Pi' }),
  s({
    trig = ';Q',
    desc = '\\Theta',
    snippetType = 'autosnippet',
  }, { t '\\Theta' }),
  s({
    trig = ';S',
    desc = '\\Sigma',
    snippetType = 'autosnippet',
  }, { t '\\Sigma' }),
  s({
    trig = ';U',
    desc = '\\Upsilon',
    snippetType = 'autosnippet',
  }, { t '\\Upsilon' }),
  s({
    trig = ';W',
    desc = '\\Omega',
    snippetType = 'autosnippet',
  }, { t '\\Omega' }),
  s({
    trig = ';X',
    desc = '\\Xi',
    snippetType = 'autosnippet',
  }, { t '\\Xi' }),
  s({
    trig = ';Y',
    desc = '\\Psi',
    snippetType = 'autosnippet',
  }, { t '\\Psi' }),
  s({
    trig = ';ve',
    desc = '\\varepsilon',
    snippetType = 'autosnippet',
  }, { t '\\varepsilon' }),
  s({
    trig = ';vf',
    desc = '\\varphi',
    snippetType = 'autosnippet',
  }, { t '\\varphi' }),
  s({
    trig = ';vk',
    desc = '\\varkappa',
    snippetType = 'autosnippet',
  }, { t '\\varkappa' }),
  s({
    trig = ';vp',
    desc = '\\varpi',
    snippetType = 'autosnippet',
  }, { t '\\varpi' }),
  s({
    trig = ';vq',
    desc = '\\vartheta',
    snippetType = 'autosnippet',
  }, { t '\\vartheta' }),
  s({
    trig = ';vr',
    desc = '\\varrho',
    snippetType = 'autosnippet',
  }, { t '\\varrho' }),
}
