return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    keys = function()
      return {
        {
          "<leader>snl",
          function()
            require("noice").cmd("last")
          end,
          desc = "Noice Last Message",
        },
        {
          "<leader>snh",
          function()
            require("noice").cmd("history")
          end,
          desc = "Noice History",
        },
        {
          "<leader>sna",
          function()
            require("noice").cmd("all")
          end,
          desc = "Noice All",
        },
        {
          "<c-f>",
          function()
            if not require("noice.lsp").scroll(4) then
              return "<c-f>"
            end
          end,
          silent = true,
          expr = true,
          desc = "Scroll forward",
          mode = {
            "i",
            "n",
            "s",
          },
        },
        {
          "<c-b>",
          function()
            if not require("noice.lsp").scroll(-4) then
              return "<c-b>"
            end
          end,
          silent = true,
          expr = true,
          desc = "Scroll backward",
          mode = {
            "i",
            "n",
            "s",
          },
        },
      }
    end,
    opts = {
      popupmenu = { backend = "cmp" },
      messages = { view_search = false },
      cmdline = {
        view = "cmdline", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
        opts = { buf_options = { filetype = "vim" } },
        format = {
          search_down = false,
          search_up = false,
        },
      },
      lsp = {
        progress = {
          enabled = false,
        },
        override = {
          -- override the default lsp markdown formatter with Noice
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          -- override the lsp markdown formatter with Noice
          ["vim.lsp.util.stylize_markdown"] = true,
          -- override cmp documentation with Noice (needs the other options to work)
          ["cmp.entry.get_documentation"] = true,
        },
        hover = {
          enabled = true,
          view = "hover", -- when nil, use defaults from documentation
          opts = {}, -- merged with defaults from documentation
        },
        signature = {
          enabled = true,
          auto_open = {
            enabled = true,
            trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
            throttle = 400, -- Debounce lsp signature help request by 50ms
          },
          view = nil, -- when nil, use defaults from documentation
          opts = {}, -- merged with defaults from documentation
        },
        message = {
          -- Messages shown by lsp servers
          enabled = true,
          view = "notify",
          opts = {},
        },
        -- defaults for hover and signature help
        documentation = {
          view = "hover",
          opts = {
            lang = "markdown",
            replace = true,
            format = { "{message}" },
            win_options = { concealcursor = "n", conceallevel = 3 },
          },
        },
      },
      presets = {
        long_message_to_split = true,
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      redirect = { { view = "popup", filter = { event = "msg_show" } } },
      views = {
        hover = {
          border = { style = "rounded" },
          size = { max_width = 80 },
        },
      },
      routes = {
        {
          view = "notify",
          filter = { find = "No information available" },
          opts = { skip = true },
        },
        {
          view = "notify",
          filter = { find = "Recording" },
          opts = { skip = true },
        },
        {
          view = "notify",
          filter = { find = "Recorded" },
          opts = { skip = true },
        },
        {
          view = "notify",
          filter = { find = "signcolumn" },
          opts = { skip = true },
        },
        {
          view = "notify",
          filter = { find = "macro" },
          opts = { skip = true },
        },
        {
          filter = { event = "msg_show", kind = "search_count" },
          opts = { skip = true },
        },
        { filter = { event = "cmdline", find = "^%s*[/?]" }, view = "cmdline" },
      },
    },
  },
}
