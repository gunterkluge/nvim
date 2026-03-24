return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  ft = { 'org' },
  config = function()
    -- Windows: Zig als Compiler fuer den org-Treesitter-Parser erzwingen
    -- WICHTIG: orgmode hat einen EIGENEN Parser-Installer, unabhaengig von
    -- nvim-treesitter! Die Einstellung in treesitter.lua hilft hier NICHT.
    if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
      require('orgmode.utils.treesitter.install').compilers = { 'zig' }
    end

    require('orgmode').setup {
      -- Alle .org-Dateien in ~/org/ werden in der Agenda angezeigt
      org_agenda_files = '~/org/**/*',
      -- Neue Captures landen hier
      org_default_notes_file = '~/org/inbox.org',
      -- TODO-Zustände: nur das Nötigste
      org_todo_keywords = { 'TODO', 'WAIT', '|', 'DONE', 'DROP' },
      -- Agenda startet am heutigen Tag
      org_agenda_start_on_weekday = false,
      mappings = {
        -- Buffer-lokale Mappings auf localleader (,) statt <leader>o
        prefix = '<localleader>',
        -- Agenda und Capture bleiben global auf <leader>
        global = {
          org_agenda = '<leader>oa',
          org_capture = '<leader>oc',
        },
        -- ci*-Mappings auf localleader umziehen,
        -- damit Vim-Textobjects (cit etc.) erhalten bleiben
        -- und which-key alles anzeigen kann
        org = {
          org_todo = '<localleader>ct',
          org_todo_prev = '<localleader>cT',
          org_change_date = '<localleader>cd',
          org_priority_up = '<localleader>cR',
          org_priority_down = '<localleader>cr',
        },
      },
      -- Ein einfaches Capture-Template: Task mit Datum
      org_capture_templates = {
        t = {
          description = 'Task',
          template = '* TODO %?\n  DEADLINE: %t',
        },
      },
    }
  end,
}
