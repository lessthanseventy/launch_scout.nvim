return {
  {
    "utilyre/barbecue.nvim",
    event = "VimEnter",
    name = "barbecue",
    version = false,
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = function()
      local c = require("rocket_dog.colors").setup({ transform = true })

      local theme = {
        normal = { bg = c.none, fg = c.fg_dark },
        ellipsis = { fg = c.dark5 },
        separator = { fg = c.dark5 },
        modified = { fg = c.warning },
        dirname = { fg = c.dark5 },
        basename = { fg = c.fg_dark, bold = true },
        context = { fg = c.fg_dark },
        context_file = { fg = c.fg_dark },
        context_module = { fg = c.yellow },
        context_namespace = { fg = c.yellow },
        context_package = { fg = c.blue },
        context_class = { fg = c.orange },
        context_method = { fg = c.blue },
        context_property = { fg = c.green1 },
        context_field = { fg = c.green1 },
        context_constructor = { fg = c.blue },
        context_enum = { fg = c.orange },
        context_interface = { fg = c.orange },
        context_function = { fg = c.blue },
        context_variable = { fg = c.magenta },
        context_constant = { fg = c.magenta },
        context_string = { fg = c.green },
        context_number = { fg = c.orange },
        context_boolean = { fg = c.orange },
        context_array = { fg = c.orange },
        context_object = { fg = c.orange },
        context_key = { fg = c.purple },
        context_null = { fg = c.blue1 },
        context_enum_member = { fg = c.green1 },
        context_struct = { fg = c.orange },
        context_event = { fg = c.orange },
        context_operator = { fg = c.green1 },
        context_type_parameter = { fg = c.green1 },
      }
      return {
        attach_navic = false, -- prevent barbecue from automatically attaching nvim-navic
        context_follow_icon_color = true,
        show_modified = true,
        theme = theme,
      }
    end,
  },
}
