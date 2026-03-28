return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  ft = { 'org' },
  config = function()
    -- Windows: Zig als Compiler fuer den org-Treesitter-Parser erzwingen
    -- WICHTIG: orgmode hat einen EIGENEN Parser-Installer, unabhaengig von
    -- nvim-treesitter! Die Einstellung in treesitter.lua hilft hier NICHT.
    if vim.fn.has 'win32' == 1 then
      require('orgmode.utils.treesitter.install').compilers = { 'zig' }
    end

    require('orgmode').setup {
      -- Alle .org-Dateien in ~/org/ werden in der Agenda angezeigt
      org_agenda_files = '~/org/**/*',
      -- Neue Captures landen hier
      org_default_notes_file = '~/org/inbox.org',
      -- TODO-Zustände: nur das Nötigste
      org_todo_keywords = { 'TODO(t)', 'WAIT(w)', '|', 'DONE(d)', 'DROP(x)' },
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
          template = '* TODO %?\n',
          target = '~/org/inbox.org',
        },
        a = {
          description = 'Termin',
          template = '* %?\n  SCHEDULED: %^T',
          target = '~/org/termine.org',
        },
        j = {
          description = 'Journal',
          template = '* %U\n%?',
          target = '~/org/journal/%<%Y-%m>.org',
        },
        r = {
          description = 'Review',
          template = '* %u Review\n** Was lief gut?\n%?\n** Was war schwierig?\n\n** Was nehme ich mit?\n',
          target = '~/org/journal/%<%Y-%m>.org',
        },
      },
      win_split_mode = 'auto',
    }

    vim.keymap.set('n', '<leader>oj', function()
      vim.cmd('edit ' .. os.date('~/org/journal/%Y-%m.org'))
    end, { desc = 'Journal oeffnen' })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'org',
      callback = function()
        -- Alt+Enter im Insert Mode: neue Headline / Listeneintrag / Checkbox
        vim.keymap.set('i', '<M-CR>', '<cmd>lua require("orgmode").action("org_mappings.meta_return")<CR>', {
          silent = true,
          buffer = true,
        })
      end,
    })

    -- Org-Dateien automatisch formatieren beim Verlassen des Insert Mode
    vim.api.nvim_create_autocmd('InsertLeave', {
      pattern = '*.org',
      callback = function()
        vim.cmd('silent normal! gggqG')
      end,
    })
  end,
}
