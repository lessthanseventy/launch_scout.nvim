return {

  {
    "dnlhc/glance.nvim",
    event = "LspAttach",
    keys = {
      {
        "gd",
        "<Cmd>Glance definitions<CR>",
        mode = { "n" },
        desc = "Glance definitions",
      },
      {
        "gl",
        "<Cmd>lua vim.diagnostic.open_float()<CR>",
        mode = { "n" },
        desc = "View diagnostic at cursor",
      },
      {
        "gr",
        "<Cmd>Glance references<CR>",
        mode = { "n" },
        desc = "Glance references",
      },
    },
    config = function()
      local glance = require("glance")
      local actions = glance.actions

      glance.setup({
        height = 18, -- Height of the window
        zindex = 45,
        preview_win_opts = {
          -- Configure preview window options
          cursorline = true,
          number = true,
          wrap = true,
        },
        border = {
          enable = true, -- Show window borders. Only horizontal borders allowed
          top_char = "―",
          bottom_char = "―",
        },
        list = {
          position = "right", -- Position of the list window 'left'|'right'
          width = 0.33, -- 33% width relative to the active window, min 0.1, max 0.5
        },
        theme = {
          -- This feature might not work properly in nvim-0.7.2
          enable = true, -- Will generate colors for the plugin based on your current colorscheme
          mode = "auto", -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
        },
        mappings = {
          list = {
            ["j"] = actions.next, -- Bring the cursor to the next item in the list
            ["k"] = actions.previous, -- Bring the cursor to the previous item in the list
            ["<Down>"] = actions.next,
            ["<Up>"] = actions.previous,
            ["<Tab>"] = actions.next_location, -- Bring the cursor to the next location skipping groups in the list
            ["<S-Tab>"] = actions.previous_location, -- Bring the cursor to the previous location skipping groups in the list
            ["<C-u>"] = actions.preview_scroll_win(5),
            ["<C-d>"] = actions.preview_scroll_win(-5),
            ["v"] = actions.jump_vsplit,
            ["s"] = actions.jump_split,
            ["t"] = actions.jump_tab,
            ["<CR>"] = actions.jump,
            ["o"] = actions.jump,
            ["<C-h>"] = actions.enter_win("preview"), -- Focus preview window
            ["q"] = actions.close,
            ["Q"] = actions.close,
            ["<Esc>"] = actions.close,
            -- ['<Esc>'] = false -- disable a mapping
          },
          preview = {
            ["Q"] = actions.close,
            ["<Tab>"] = actions.next_location,
            ["<S-Tab>"] = actions.previous_location,
            ["<C-l>"] = actions.enter_win("list"), -- Focus list window
          },
        },
        hooks = {
          before_open = function(results, open, jump, method)
            local uri = vim.uri_from_bufnr(0)
            if #results == 1 then
              local target_uri = results[1].uri or results[1].targetUri

              if target_uri == uri then
                jump(results[1])
              else
                open(results)
              end
            else
              open(results)
            end
          end,
        },
        folds = {
          fold_closed = "",
          fold_open = "",
          folded = false, -- Automatically fold list on startup
        },
        indent_lines = { enable = true, icon = "│" },
        winbar = {
          enable = true, -- Available strating from nvim-0.8+
        },
      })
    end,
  },
}
