return {
  {
    "gelguy/wilder.nvim",
    lazy = false,
    dependencies = {
      {
        "romgrk/fzy-lua-native",
      },
      {
        "nixprime/cpsm",
        build = "./install.sh",
      },
    },
    config = function()
      local wilder = require("wilder")
      wilder.setup({ modes = { ":", "/", "?" } })

      wilder.set_option("pipeline", {
        wilder.branch(
          wilder.python_file_finder_pipeline({
            file_command = function(ctx, arg)
              if string.find(arg, ".") ~= nil then
                return { "fd", "-tf", "-H" }
              else
                return { "fd", "-tf" }
              end
            end,
            dir_command = { "fd", "-td" },
            filters = { "cpsm_filter" },
          }),
          wilder.substitute_pipeline({
            pipeline = wilder.python_search_pipeline({
              skip_cmdtype_check = 1,
              pattern = wilder.python_fuzzy_pattern({
                start_at_boundary = 0,
              }),
            }),
          }),
          wilder.cmdline_pipeline({
            fuzzy = 1,
            fuzzy_filter = wilder.lua_fzy_filter(),
          }),
          {
            wilder.check(function(ctx, x)
              return x == ""
            end),
            wilder.history(),
          },
          wilder.python_search_pipeline({
            pattern = wilder.python_fuzzy_pattern({
              start_at_boundary = 0,
            }),
          })
        ),
      })

      local gradient = {
        "#f4468f",
        "#fd4a85",
        "#ff507a",
        "#ff566f",
        "#ff5e63",
        "#ff6658",
        "#ff704e",
        "#ff7a45",
        "#ff843d",
        "#ff9036",
        "#f89b31",
        "#efa72f",
        "#e6b32e",
        "#dcbe30",
        "#d2c934",
        "#c8d43a",
        "#bfde43",
        "#b6e84e",
        "#aff05b",
      }

      for i, fg in ipairs(gradient) do
        gradient[i] = wilder.make_hl("WilderGradient" .. i, "Pmenu", { { a = 1 }, { a = 1 }, { foreground = fg } })
      end

      local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_palette_theme({
        -- 'single', 'double', 'rounded' or 'solid'
        -- can also be a list of 8 characters, see :h wilder#popupmenu_palette_theme() for more details
        border = "rounded",
        max_height = "25%", -- max height of the palette
        min_height = 0, -- set to the same as 'max_height' for a fixed height window
        max_width = "25%",
        pumblend = 15,
        prompt_position = "top", -- 'top' or 'bottom' to set the location of the prompt
        reverse = 0, -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
        empty_message = wilder.popupmenu_empty_message_with_spinner(),
        highlights = {
          border = "Structure", -- highlight to use for the border
          gradient = gradient, -- must be set
        },
        highlighter = wilder.highlighter_with_gradient({
          wilder.lua_fzy_highlighter(),
        }),
        left = {
          " ",
          wilder.popupmenu_devicons(),
          wilder.popupmenu_buffer_flags({
            flags = " a + ",
            icons = { ["+"] = "", a = "", h = "" },
          }),
        },
        right = {
          " ",
          wilder.popupmenu_scrollbar(),
        },
      }))

      local wildmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_palette_theme({
        highlights = {
          border = "Structure", -- highlight to use for the border
          gradient = gradient, -- must be set
        },
        highlighter = wilder.highlighter_with_gradient({
          wilder.lua_fzy_highlighter(),
        }),
        pumblend = 15,
        min_width = "25%",
        max_width = "25%",
        max_height = "25%",
        min_height = 0,
        border = "double",
      }))

      wilder.set_option(
        "renderer",
        wilder.renderer_mux({
          [":"] = popupmenu_renderer,
          ["/"] = wildmenu_renderer,
          substitute = wildmenu_renderer,
        })
      )
    end,
  },
}
