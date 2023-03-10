return {
  {
    "hrsh7th/nvim-cmp",
    event = "VimEnter",
    version = false,
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "windwp/nvim-autopairs",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind.nvim",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        version = false,
        keys = {},
        dependencies = {
          "rafamadriz/friendly-snippets",
          {
            "petalframework/vscode_petal_components_snippets",
            config = function()
              local ls = require("luasnip")
              require("luasnip.loaders.from_vscode").load({ -- Lazy loading
                paths = { "~/.local/share/nvim/lazy/vscode_petal_components_snippets/snippets" },
              })
            end,
          },
          {
            "honza/vim-snippets",
            config = function()
              local ls = require("luasnip")
              ls.filetype_extend("all", { "_" })
              require("luasnip.loaders.from_snipmate").lazy_load() -- Lazy loading
            end,
          },
        },
        opts = {
          enable_autosnippets = false,
        },
      },
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local keymaps = require("config.plugins.lsp_keymaps")

      local lspkind = require("lspkind")

      local formatting_pots = {
        fields = { "kind", "abbr", "menu" },
        format = lspkind.cmp_format({
          mode = "symbol_text", -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
          maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          menu = { -- showing type in menu
            nvim_lsp = "[LSP]",
            buffer = "[Buffer]",
            luasnip = "[Snip]",
            calc = "[Calc]",
            path = "[Path]",
          },
          before = function(entry, vim_item) -- for tailwind css autocomplete
            if vim_item.kind == "Color" and entry.completion_item.documentation then
              local _, _, r, g, b = string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
              if r then
                local color = string.format("%02x", r) .. string.format("%02x", g) .. string.format("%02x", b)
                local group = "Tw_" .. color
                if vim.fn.hlID(group) < 1 then
                  vim.api.nvim_set_hl(0, group, { fg = "#" .. color })
                end
                vim_item.kind = "■" -- or "⬤" or anything
                vim_item.kind_hl_group = group
                return vim_item
              end
            end
            -- vim_item.kind = icons[vim_item.kind] and (icons[vim_item.kind] .. vim_item.kind) or vim_item.kind
            -- or just show the icon
            vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
            return vim_item
          end,
        }),
      }

      return {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        completion = {
          autocomplete = {
            cmp.TriggerEvent.TextChanged,
          },
          completeopt = "menu,menuone",
        },
        mapping = keymaps,
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer", max_item_count = 4 },
          { name = "path", max_item_count = 8 },
          { name = "luasnip", max_item_count = 4, option = { show_autosnippets = false } },
        }),
        formatting = formatting_pots,
        experimental = {
          ghost_text = {
            hl_group = "LspCodeLens",
          },
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        view = {
          entries = "custom",
        },
      }
    end,
    config = function(_, opts)
      local cmp = require("cmp")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")

      -- `/` cmdline setup.
      cmp.setup.cmdline("/", {
        sources = {
          { name = "buffer" },
        },
      })

      -- `:` cmdline setup.
      cmp.setup.cmdline(":", {
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })

      cmp.setup(opts)
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      -- stop snippets when you leave to normal mode
    end,
  },
}
