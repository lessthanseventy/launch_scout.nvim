return {
  {
    "renerocksai/telekasten.nvim",
    keys = {
      { "<leader>zf", ":lua require('telekasten').find_notes()<CR>", desc = "Find notes" },
      { "<leader>zd", ":lua require('telekasten').find_daily_notes()<CR>", desc = "Find daily notes" },
      { "<leader>zg", ":lua require('telekasten').search_notes()<CR>", desc = "Search notes" },
      { "<leader>zz", ":lua require('telekasten').follow_link()<CR>", desc = "Follow link" },
      { "<leader>zT", ":lua require('telekasten').goto_today()<CR>", desc = "Go to today" },
      { "<leader>zW", ":lua require('telekasten').goto_thisweek()<CR>", desc = "Go to this week" },
      { "<leader>zw", ":lua require('telekasten').find_weekly_notes()<CR>", desc = "Find weekly notes" },
      { "<leader>zn", ":lua require('telekasten').new_note()<CR>", desc = "New note" },
      { "<leader>zN", ":lua require('telekasten').new_templated_note()<CR>", desc = "New templated note" },
      { "<leader>zy", ":lua require('telekasten').yank_notelink()<CR>", desc = "Yank note link" },
      { "<leader>zc", ":lua require('telekasten').show_calendar()<CR>", desc = "Show calendar" },
      { "<leader>zC", ":CalendarT<CR>", desc = "Show calendar in tab" },
      { "<leader>zi", ":lua require('telekasten').paste_img_and_link()<CR>", desc = "Paste image and link" },
      { "<leader>zt", ":lua require('telekasten').toggle_todo()<CR>", desc = "Toggle todo" },
      { "<leader>zb", ":lua require('telekasten').show_backlinks()<CR>", desc = "Show Backlinks" },
      { "<leader>zF", ":lua require('telekasten').find_friends()<CR>", desc = "Find friends" },
      { "<leader>zI", ":lua require('telekasten').insert_img_link({ i=true })<CR>", desc = "Insert image link" },
      { "<leader>zp", ":lua require('telekasten').preview_img()<CR>", desc = "Preview image" },
      { "<leader>zm", ":lua require('telekasten').browse_media()<CR>", desc = "Browse media" },
      { "<leader>za", ":lua require('telekasten').show_tags()<CR>", desc = "Show tags" },
      { "<leader>zr", ":lua require('telekasten').rename_note()<CR>", desc = "Rename note" },
      { "<leader>zl", ":lua require('telekasten').insert_link({ i=true })<CR>", desc = "Insert link" },
    },
    dependencies = {
      "renerocksai/calendar-vim",
      "nvim-telescope/telescope.nvim",
      "ixru/nvim-markdown",
    },
    opts = function()
      local home = vim.fn.expand("~/.vault/home/")
      local home = vim.fn.expand("~/.vault/work/")
      return {
        vaults = { home, work },
        dailies = home .. "/" .. "daily",
        weeklies = home .. "/" .. "weekly",
        templates = home .. "/" .. "templates",
        -- template for new notes (new_note, follow_link)
        template_new_note = home .. "/" .. "templates/new_note.md",

        -- template for newly created daily notes (goto_today)
        template_new_daily = home .. "/" .. "templates/daily.md",

        -- template for newly created weekly notes (goto_thisweek)
        template_new_weekly = home .. "/" .. "templates/weekly.md", -- template for new notes (new_note, follow_link)
        calendar_opts = {
          -- calendar week display mode: 1 .. 'WK01', 2 .. 'WK 1', 3 .. 'KW01', 4 .. 'KW 1', 5 .. '1'
          weeknm = 1,
          -- use monday as first day of week: 1 .. true, 0 .. false
          calendar_monday = 0,
          -- calendar mark: where to put mark for marked days: 'left', 'right', 'left-fit'
        },
      }
    end,
  },
}
