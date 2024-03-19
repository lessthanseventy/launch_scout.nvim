return {
  {
    "b0o/incline.nvim",
    dependencies = { "SmiteshP/nvim-navic" },
    config = function()
      local devicons = require("nvim-web-devicons")
      local helpers = require("incline.helpers")
      local navic = require("nvim-navic")
      require("incline").setup({
        hide = {
          cursorline = true,
          focused_win = false,
          only_win = false,
        },
        window = {
          margin = {
            horizontal = 5,
            vertical = 2,
          },
          placement = {
            horizontal = "right",
            vertical = "top",
          },
        },
        ignore = {
          buftypes = "special",
          filetypes = { "sql" },
          floating_wins = true,
          unlisted_buffers = true,
          wintypes = "special",
        },
        render = function(props)
          -- local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          -- if filename == "" then
          --   filename = "[No Name]"
          -- end
          local fullPath = vim.api.nvim_buf_get_name(props.buf)
          local filename = vim.fn.fnamemodify(fullPath, ":t") -- Extracts the filename
          local directoryPath = vim.fn.fnamemodify(fullPath, ":h") -- Extracts the full directory path
          local immediateDir = vim.fn.fnamemodify(directoryPath, ":t") -- Extracts the immediate directory name

          if fullPath == "" then
            filename = "[No Name]"
          else
            filename = immediateDir .. "/" .. filename -- Concatenates the immediate directory and filename
          end
          local ft_icon, ft_color = devicons.get_icon_color(filename)

          local function get_git_diff()
            local icons = { removed = " ", changed = " ", added = " " }
            local signs = vim.b[props.buf].gitsigns_status_dict
            local labels = {}
            if signs == nil then
              return labels
            end
            for name, icon in pairs(icons) do
              if tonumber(signs[name]) and signs[name] > 0 then
                table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
              end
            end
            if #labels > 0 then
              table.insert(labels, { "┊ " })
            end
            return labels
          end

          local function get_diagnostic_label()
            local icons = { error = " ", warn = " ", info = " ", hint = " " }
            local label = {}

            for severity, icon in pairs(icons) do
              local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
              if n > 0 then
                table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
              end
            end
            if #label > 0 then
              table.insert(label, { "┊ " })
            end
            return label
          end

          return {
            { get_diagnostic_label() },
            { get_git_diff() },
            { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
            { filename .. " ", gui = vim.bo[props.buf].modified and "bold,italic" or "bold" },
            { "┊  " .. vim.api.nvim_win_get_number(props.win), group = "DevIconWindows" },
          }
        end,
      })
    end,
    -- Optional: Lazy load Incline
    event = "VeryLazy",
  },
}
