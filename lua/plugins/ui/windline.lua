return {
  {
    "windwp/windline.nvim",
    dependencies = "linrongbin16/lsp-progress.nvim",
    config = function()
      local recorder = require("recorder")
      local windline = require("windline")
      local cache_utils = require("windline.cache_utils")
      local fn = vim.fn
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

      local function get_buf_name(modify, shorten)
        return function(bufnr)
          local bufname = fn.bufname(bufnr)
          bufname = fn.fnamemodify(bufname, modify)
          if shorten then
            return fn.pathshorten(bufname)
          end
          return bufname
        end
      end

      local file_name = function(default, modify)
        default = default or "[No Name]"
        local fnc_name = get_buf_name("%:p", false)
        return function(bufnr)
          local name = fnc_name(bufnr)
          if name == "" then
            name = default
          end
          return " " .. name .. " "
        end
      end

      local cache_file_name = function(default, modify)
        return cache_utils.cache_on_buffer("BufEnter", "WL_filename", file_name(default, modify))
      end

      basic.file_name = {
        name = "file_name",
        hl_colors = {
          default = hl_list.Black,
          white = { "white", "black" },
          magenta = { "magenta", "black" },
          yellow_light = { "black", "yellow_light" },
        },
        text = function(_, _, _)
          return {
            { cache_file_name("[No Name]", "full"), "yellow_light" },
            { b_components.file_modified(" "), "yellow_light" },
          }
        end,
      }

      basic.file_pos = {
        name = "file_pos",
        hl_colors = {
          default = hl_list.Black,
          green = { "green", "black" },
        },
        text = function(_, _, _)
          return {
            { b_components.line_col_lua, "green" },
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
          { "", { "black", "yellow_light" } },
          basic.file_name,
          { "", { "black", "yellow_light" } },
          { " ", hl_list.Black },
          basic.lsp_name,
          basic.lsp_status,
          basic.divider,
          basic.recorder_status,
          basic.recorder_slots,
          { " ", hl_list.Black },
          basic.file_pos,
          { " ", hl_list.Black },
          { "", { "white_light", "black" } },
          { git_comps.git_branch(), { "black", "white_light" } },
          { " ", { "black", "white_light" } },
          { "", { "white_light", "black" } },
          { " ", hl_list.Black },
        },
        inactive = {},
      }

      windline.setup({
        colors_name = function(colors)
          colors.StatusFg = colors.ActiveFg
          colors.StatusBg = colors.ActiveBg
          return colors
        end,
        theme = {
          black = "#080808",
          white = "#b5c1f1",
          red = "#ea7183",
          green = "#33FF00",
          blue = "#739df2",
          yellow = "#FFB000",
          cyan = "#68bae0",
          magenta = "#efc9c2",
          black_light = "#2c2f40",
          white_light = "#959ec2",
          red_light = "#f39967",
          yellow_light = "#fabd2f",
          blue_light = "#517f8d",
          magenta_light = "#a6b0d8",
          green_light = "#78cec1",
          cyan_light = "#91d7e3",

          NormalFg = "#b5c1f1",
          NormalBg = "#080808",
          InactiveFg = "#b5c1f1",
          InactiveBg = "#080808",
          ActiveFg = "#b5c1f1",
          ActiveBg = "#080808",
        },
        statuslines = {
          default,
          quickfix,
          explorer,
        },
      })
    end,
  },
}
