local ls = require 'luasnip'
local s = ls.snippet
local fmt = require('luasnip.extras.fmt').fmt
local d = require('luasnip.extras').partial

return {
  -- 🗓️ Datum einmal am Anfang
  s(
    'datum',
    fmt('🗓️ {}\n', {
      d(function()
        return os.date '%Y-%m-%d'
      end),
    })
  ),

  -- 🕒 Uhrzeit für spontane Logs
  s(
    'uhrzeit',
    fmt('🕒 {}\n', {
      d(function()
        return os.date '%H:%M'
      end),
    })
  ),

  -- 🌞 Morgenseite
  s(
    'morgen',
    fmt(
      [[
## 🌞 Morgenseite
🕒 Startzeit: {}

- **Wie fühle ich mich gerade beim Aufwachen?**
  >

- **Was beschäftigt mich am meisten?**
  >

- **Worauf möchte ich heute meine Energie lenken?**
  >

- **Ein kleiner Satz für mich heute:**
  > *Ich …*
]],
      {
        d(function()
          return os.date '%H:%M'
        end),
      }
    )
  ),

  -- 🌙 Abendreflexion
  s(
    'abend',
    fmt(
      [[
## 🌙 Abendreflexion
🕒 Zeitpunkt: {}

- **Was ist heute passiert oder war wichtig für mich?**
  >

- **Welche Gedanken kreisen mir durch den Kopf?**
  >

- **Was habe ich heute über mich oder das Leben gelernt?**
  >

- **A-Seite – kleine Schritte:**
  > Bewegung: ___
  > Zigaretten: ___
  > Ernährung: ___

- **Ein Moment, in dem ich bei mir war:**
  >
]],
      {
        d(function()
          return os.date '%H:%M'
        end),
      }
    )
  ),

  -- ✅ To-do / Absichtsliste
  s(
    'todo',
    fmt(
      [[
## ✅ To-do / Absichtsliste

- [ ] Bewegung (z. B. 15 Min Spaziergang)
- [ ] Etwas Gutes essen
- [ ] Pause bewusst machen
- [ ] Achtsamkeit: ___
- [ ] Freude: ___
]],
      {}
    )
  ),

  -- 📊 A-Seite Tracker (optional)
  s(
    'atrack',
    fmt(
      [[
## 📊 A-Seite Tracker

| Kategorie        | Beschreibung / Notizen                         |
|------------------|------------------------------------------------|
| 🚬 Zigaretten     | Anzahl heute: ___                             |
| 🥗 Ernährung      | Was habe ich gegessen?                        |
| 🏃 Bewegung        | Art & Dauer                                   |
| 💧 Trinken         | Ca. wie viel Wasser?                          |
| 😌 Achtsamkeit     | 1 bewusster Moment?                           |
| 🪷 A-Seiten-Moment | Wann war ich ganz bei mir?                   |
]],
      {}
    )
  ),
}
