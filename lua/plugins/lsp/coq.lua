local LSPMaps = require("config.plugins.lsp_keymaps")

return {
  {
    "ms-jpq/coq_nvim",
    keys = {
      {
        "<C-j>",
        LSPMaps.C_j,
        expr = true,
        silent = true,
        mode = "i",
      },
      {
        "<C-k>",
        LSPMaps.C_k,
        expr = true,
        silent = true,
        mode = "i",
      },
      {
        "<C-c>",
        LSPMaps.C_c,
        expr = true,
        silent = true,
        mode = "i",
      },
      {
        "<BS>",
        LSPMaps.BS,
        expr = true,
        silent = true,
        mode = "i",
      },
      {
        "<CR>",
        LSPMaps.CR,
        expr = true,
        silent = true,
        mode = "i",
      },
      {
        "<Tab>",
        LSPMaps.Tab,
        expr = true,
        silent = true,
        mode = "i",
      },
      {
        "<S-Tab>",
        LSPMaps.S_Tab,
        expr = true,
        silent = true,
        mode = "i",
      },
    },
    commit = "5eddd31bf8a98d1b893b0101047d0bb31ed20c49",
    init = function()
      vim.g.coq_settings = {
        auto_start = true,
        keymap = {
          recommended = false,
          bigger_preview = "<c-->",
          jump_to_mark = "<c-i>",
        },
        limits = {
          completion_auto_timeout = 0.15,
          completion_manual_timeout = 0.8,
        },
        clients = {
          lsp = {
            resolve_timeout = 0.15,
            weight_adjust = 1.5,
          },
          snippets = {
            enabled = true,
          },
        },
      }
    end,
    dependencies = {
      {
        "ms-jpq/coq.artifacts",
        branch = "artifacts",
      },
      {
        "ms-jpq/coq.thirdparty",
        branch = "3p",
      },
    },
    config = function()
      require("coq_3p")({
        { src = "nvimlua", short_name = "nLUA", conf_only = true },
        { src = "bc", short_name = "MATH", precision = 6 },
        { src = "vim_dadbod_completion", short_name = "DB" },
      })
    end,
  },
}
