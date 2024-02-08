return {
  {
    "Bekaboo/dropbar.nvim",
    -- optional, but required for fuzzy finder support
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    opts = {
      general = {
        update_events = {
          win = { "CursorMoved", "CursorMovedI", "WinResized" },
        },
      },
      icons = {
        ui = {
          bar = {
            separator = " ⏵ ",
          },
        },
      },
      bar = {
        sources = function()
          local sources = require("dropbar.sources")
          local utils = require("dropbar.utils.source")

          -- Just show the path info for non-active windows.
          return {
            sources.path,
            {
              get_symbols = function(buf, win, cursor)
                if vim.api.nvim_get_current_win() ~= win then
                  return {}
                end

                if vim.bo[buf].ft == "markdown" then
                  return sources.markdown.get_symbols(buf, win, cursor)
                end

                return utils.fallback({ sources.lsp, sources.treesitter }).get_symbols(buf, win, cursor)
              end,
            },
          }
        end,
      },
    },
    config = function(_, opts)
      require("dropbar").setup(opts)
      vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
        callback = function()
          -- Refresh the dropbars except when entering the dropbar itself.
          if vim.fn.getwininfo(vim.api.nvim_get_current_win())[1].winbar == 1 then
            require("dropbar.utils.bar").exec("update")
          end
        end,
      })
    end,
  },
}
