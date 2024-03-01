return {
  {
    "windwp/windline.nvim",
    dependencies = "linrongbin16/lsp-progress.nvim",
    config = function()
      local recorder = require("recorder")
      local windline = require("windline")
      local cava_component = require("windline.components.cava")
      cava_component.is_stop = false
      local helper = require("windline.helpers")
      local b_components = require("windline.components.basic")
      local state = _G.WindLine.state

      local lsp_comps = require("windline.components.lsp")
      local git_comps = require("windline.components.git")

      local hl_list = {
        Black = { "white", "black" },
        White = { "black", "white" },
        Inactive = { "InactiveFg", "InactiveBg" },
        Active = { "ActiveFg", "ActiveBg" },
      }
      local basic = {}

      basic.divider = { b_components.divider, "" }
      basic.bg = { " ", "StatusLine" }

      local colors_mode = {
        Normal = { "red", "black" },
        Insert = { "green", "black" },
        Visual = { "yellow", "black" },
        Replace = { "blue_light", "black" },
        Command = { "magenta", "black" },
      }

      basic.vi_mode = {
        name = "vi_mode",
        hl_colors = colors_mode,
        text = function()
          return { { "󱓞 ", state.mode[2] } }
        end,
      }

      basic.recorder_status = {
        name = "recorder",
        hl_colors = {
          default = hl_list.Black,
          white = { "white", "black" },
          magenta = { "magenta", "black" },
        },
        text = function()
          return {
            { recorder.recordingStatus() },
          }
        end,
      }

      basic.recorder_slots = {
        name = "recorder",
        hl_colors = {
          default = hl_list.Black,
          white = { "white", "black" },
          magenta = { "magenta", "black" },
        },
        text = function()
          return {
            { recorder.displaySlots() },
          }
        end,
      }

      basic.file_name = {
        name = "file_name",
        hl_colors = {
          default = hl_list.Black,
          white = { "white", "black" },
          magenta = { "magenta", "black" },
        },
        text = function(_, _, _)
          return {
            { " ", "" },
            { b_components.cache_file_name("[No Name]", "unique"), "magenta" },
            { " ", "" },
            { b_components.file_modified(" "), "magenta" },
          }
        end,
      }

      basic.file_pos = {
        name = "file_pos",
        hl_colors = {
          default = hl_list.Black,
          white = { "white", "black" },
        },
        text = function(_, _, _)
          return {
            { b_components.line_col_lua, "white" },
            { b_components.progress_lua, "" },
            { " ", "" },
          }
        end,
      }

      basic.lsp_name = {
        name = "lsp_name",
        hl_colors = {
          magenta = { "magenta", "black" },
        },
        text = function(bufnr)
          if lsp_comps.check_lsp(bufnr) then
            return {
              { lsp_comps.lsp_name(), "magenta" },
            }
          end
          return {
            { b_components.cache_file_type({ icon = true }), "magenta" },
          }
        end,
      }

      local function LspStatus()
        return require("lsp-progress").progress({
          format = function(messages)
            return #messages > 0 and table.concat(messages, " ") or ""
          end,
        })
      end

      basic.lsp_status = {
        name = "lsp_status",
        hl_colors = {
          blue = { "blue", "black" },
        },
        text = function(bufnr)
          if lsp_comps.check_lsp(bufnr) then
            return {
              { " " .. LspStatus(), "blue" },
            }
          end
          return ""
        end,
      }

      local quickfix = {
        filetypes = { "qf", "Trouble" },
        active = {
          { "🚦 Quickfix ", { "white", "black" } },
          { helper.separators.slant_right, { "black", "black_light" } },
          {
            function()
              return vim.fn.getqflist({ title = 0 }).title
            end,
            { "cyan", "black_light" },
          },
          { " Total : %L ", { "cyan", "black_light" } },
          { helper.separators.slant_right, { "black_light", "InactiveBg" } },
          { " ", { "InactiveFg", "InactiveBg" } },
          basic.divider,
          { helper.separators.slant_right, { "InactiveBg", "black" } },
          { "🧛 ", { "white", "black" } },
        },

        always_active = true,
        show_last_status = true,
      }

      local explorer = {
        filetypes = { "fern", "neo-tree", "lir" },
        active = {
          { "  ", { "black", "red" } },
          { helper.separators.slant_right, { "red", "NormalBg" } },
          { b_components.divider, "" },
          { b_components.file_name(""), { "white", "NormalBg" } },
        },
        always_active = true,
        show_last_status = true,
      }

      local default = {
        filetypes = { "default" },
        active = {
          basic.vi_mode,
          basic.file_name,
          basic.lsp_name,
          basic.lsp_status,
          basic.divider,
          basic.recorder_status,
          basic.recorder_slots,
          { " ", hl_list.Black },
          basic.file_pos,
          { " ", hl_list.Black },
          { git_comps.git_branch(), { "magenta", "black" } },
          { " ", hl_list.Black },
        },
        inactive = {},
      }

      windline.setup({
        colors_name = function(colors)
          -- print(vim.inspect(colors))
          -- ADD MORE COLOR HERE ----
          return colors
        end,
        statuslines = {
          default,
          quickfix,
          explorer,
        },
      })
    end,
  },
}
